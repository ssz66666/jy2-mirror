local rdebug = require('remotedebug')

local function expand_value(val, opt, cache, depth)
    -- 基本类型，自身就是值
    if type(val) ~= 'userdata' then
        return val
    end

    -- 引用类型，rdebug.value() 返回值有两种
    --   * 如果是 lightuserdata，返回这个 lightuserdata 本身
    --   * 非 lightuserdata，返回一个表示地址的字符串
    local v = rdebug.value(val)
    local id
    if v == val then
        id = tostring(v)
    else
        id = v:sub(2, -2) -- 去掉头尾的方括号
    end

    -- 从缓存取出已经获取过的
    local ref = cache.refs[id]
    if ref then
        return ref
    end

    -- 这个引用对象在 host vm 里的类型
    -- 在 debug vm 里全部用一个 table 来表示，host vm 的元数据
    -- 保存在这个 table 的 metatable 里
    ref = {}
    local t = rdebug.type(val)
    local ref_mt = {
        __HOST_OBJ__ = true,
        __HOST_TYPE__ = t,
        __HOST_TOSTRING__ = id,
    }
    setmetatable(ref, ref_mt)

    -- 避免爆栈，限制递归深度和数量
    if opt.max_depth and depth >= opt.max_depth then
        ref_mt.__HOST_LIMITED__ = 'depth'
        return ref
    end
    if opt.max_count and cache.count >= opt.max_count then
        ref_mt.__HOST_LIMITED__ = 'count'
        return ref
    end

    -- 加入缓存，并递归深度和数量递增
    cache.refs[id] = ref
    cache.count = cache.count + 1
    depth = depth + 1

    -- 开始获取更多引用对象的元数据

    if t == 'function' then
        local info = rdebug.props(val);
        if info.pointer_address then
            ref_mt.__HOST_INFO_NATIVE__ = true
            ref_mt.__HOST_INFO_POINTER_ADDRESS__ = info.pointer_address
            ref_mt.__HOST_INFO_SYMBOL_BASE__ = info.symbol_base
            ref_mt.__HOST_INFO_SYMBOL_FILE__ = info.symbol_file
        else
            ref_mt.__HOST_INFO_NATIVE__ = false
            ref_mt.__HOST_INFO_FILE__ = info.source
            ref_mt.__HOST_INFO_LINE_BEGIN__ = info.linedefined
            ref_mt.__HOST_INFO_LINE_END__ = info.lastlinedefined
        end
        return ref
    end

    if t == 'table' then
        local val_mt = rdebug.getmetatable(val)
        if val_mt then
            ref_mt.__HOST_METATABLE__ = expand_value(val_mt, opt, cache, depth)
        end

        local next_key, next_value
        while true do
            next_key, next_value = rdebug.next(val, next_key)
            if next_key == nil then
                break
            end

            local expanded_next_key = expand_value(next_key, opt, cache, depth)
            ref[expanded_next_key] = expand_value(next_value, opt, cache, depth)
        end

        return ref
    end

    if t == 'userdata' then
        local val_mt = rdebug.getmetatable(val)
        if val_mt then
            ref_mt.__HOST_METATABLE__ = expand_value(val_mt, opt, cache, depth)
        end
        return ref
    end

    if t == 'thread' then
        ref_mt.__HOST_INFO_STATUS__ = rdebug.props(val)
        return ref
    end

    return nil
end

local expand_to_array = function(items)
    local opt = {max_depth=8, max_count=8096}
    local cache = {refs={}, count=0}

    local ret = {}
    for _, item in ipairs(items) do
        local value = expand_value(item[2], opt, cache, 0)
        table.insert(ret, value)
    end
    return ret
end

local expand_to_dict = function(items)
    local opt = {max_depth=8, max_count=8096}
    local cache = {refs={}, count=0}

    local ret = {}
    local temporary_count = 0
    local temporary_dict = {}
    local vararg_count = 0
    local vararg_dict = {}
    local retarg_count = 0
    local retarg_dict = {}

    for _, item in ipairs(items) do
        local name = item[1]
        local value = expand_value(item[2], opt, cache, 0)

        if name == '(*temporary)' then
            temporary_count = temporary_count + 1
            temporary_dict[temporary_count] = value
        elseif name == '(*vararg)' then
            vararg_count = vararg_count + 1
            vararg_dict[vararg_count] = value
        elseif name == '(*retarg)' then
            retarg_count = retarg_count + 1
            retarg_dict[retarg_count] = value
        else
            ret[name] = value
        end
    end

    if temporary_count > 0 then
        local mt = {
            __HOST_OBJ__ = true,
            __HOST_TYPE__ = 'table',
            __HOST_TOSTRING__ = '(*temporary)',
        }
        setmetatable(temporary_dict, mt)
        ret['(*temporary)'] = temporary_dict
    end
    if vararg_count > 0 then
        local mt = {
            __HOST_OBJ__ = true,
            __HOST_TYPE__ = 'table',
            __HOST_TOSTRING__ = '(*vararg)',
        }
        setmetatable(vararg_dict, mt)
        ret['(*vararg)'] = vararg_dict
    end
    if retarg_count > 0 then
        local mt = {
            __HOST_OBJ__ = true,
            __HOST_TYPE__ = 'table',
            __HOST_TOSTRING__ = '(*retarg)',
        }
        setmetatable(retarg_dict, mt)
        ret['(*retarg)'] = retarg_dict
    end

    return ret
end

return {
    expand_to_array = expand_to_array,
    expand_to_dict = expand_to_dict,
}
