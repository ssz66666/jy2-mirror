-- Lua 对象结构描述库

-- 节点表示的数据类型
local TAG_SPECIAL = 'special'
local TAG_LITERAL = 'literal'
local TAG_REFERENCE = 'reference'
local TAG_LIMIT_DEPTH = 'limit-depth'
local TAG_LIMIT_COUNT = 'limit-count'

-- 无视 metamethod 的 tostring
local rawtostring = function(obj)
    local mt = debug.getmetatable(obj)
    if not mt then
        return tostring(obj)
    end
    local func = mt.__tostring
    mt.__tostring = nil
    local str = tostring(obj)
    mt.__tostring = func
    return str
end

-- 无视 metamethod 的 pairs
local rawpairs = function(tbl)
    return next, tbl, nil
end

-- 是否正无穷
local isinfpos = function(num)
    return math.huge == num
end

-- 是否负无穷
local isinfneg = function(num)
    return -math.huge == num
end

-- 是否 NaN
local isnan = function(num)
    return num ~= num
end

-- 返回一个 table，这个 table 描述了某个 Lua 值的数据类型和结构，带递归处理
local function dumpval(val, opt, mem, depth)
    local t = type(val)

    -- 特殊类型
    if t == 'number' then
        if isinfpos(val) then
            return {tag=TAG_SPECIAL, arg='inf'}
        end
        if isinfneg(val) then
            return {tag=TAG_SPECIAL, arg='-inf'}
        end
        if isnan(val) then
            return {tag=TAG_SPECIAL, arg='nan'}
        end
    end

    -- 字面量类型
    local tp = t == 'nil' or t == 'boolean' or t == 'number' or t == 'string'
    if tp then
        return {tag=TAG_LITERAL, arg=val}
    end

    -- 余下都是引用类型了，生成一个字符串 id，以及节点对象
    local id = rawtostring(val)
    local node = {tag=TAG_REFERENCE, arg=id}

    -- 看看是否已经在引用集里
    local ref = mem.refs[id]
    if ref then
        return node
    end

    -- 避免爆栈，限制递归深度和数量
    if opt.max_depth and depth >= opt.max_depth then
        return {tag=TAG_LIMIT_DEPTH, arg=id}
    end
    if opt.max_count and mem.count >= opt.max_count then
        return {tag=TAG_LIMIT_COUNT, arg=id}
    end

    -- 创建一个引用对象并塞到引用集里
    ref = {type=t}
    mem.refs[id] = ref

    -- 递归深度和数量递增
    mem.count = mem.count + 1
    depth = depth + 1

    -- function 类型
    -- 记下函数定义的类型、文件名和行号
    -- 不是很想用 debug 库，不知道有没有副作用
    if t == 'function' then
        local info = debug.getinfo(val, 'S')
        ref.native = info.what == 'C'
        if not ref.native then
            ref.file = info.source
            ref.line_begin = info.linedefined
            ref.line_end = info.lastlinedefined
        end
        return node
    end

    -- thread 类型
    -- 好像只有状态能记下
    if t == 'thread' then
        local status = coroutine.status(val)
        ref.status = status
        return node
    end

    -- userdata 类型
    -- 好像只有 metatable 能记下
    if t == 'userdata' then
        local metatable = debug.getmetatable(t)
        if metatable then
            metatable = dumpval(metatable, opt, mem, depth)
        end
        ref.metatable = metatable
        return node
    end

    -- table 类型
    -- 记下无视 metamethod 的 key-value 对，以及 metatable
    if t == 'table' then
        local items = {}
        for k, v in rawpairs(val) do
            local item = {
                key = dumpval(k, opt, mem, depth),
                value = dumpval(v, opt, mem, depth),
            }
            table.insert(items, item)
        end

        local metatable = debug.getmetatable(val)
        if metatable then
            metatable = dumpval(metatable, opt, mem, depth)
        end

        ref.items = items
        ref.metatable = metatable
        return node
    end

    -- 不应该能跑到这里
    error('unknow value "%s" type "%s"', val, t)
end

-- 外层包装函数
local dump = function(val, opt)
    opt = opt or {}
    opt.max_depth = opt.max_depth
    opt.max_count = opt.max_count
    local mem = {refs={}, count=0}
    local root = dumpval(val, opt, mem, 0)
    return {
        root = root,
        refs = mem.refs,
        count = mem.count,
        option = opt,
    }
end

return {
    dump=dump,
}
