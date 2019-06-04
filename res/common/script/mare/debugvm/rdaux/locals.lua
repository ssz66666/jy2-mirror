local rdebug = require('remotedebug')
local aux_common = require('mare/debugvm/rdaux/common')

-- 根据 event 的类型，统一下 (*temporary) 的意义
local normalize_temporary_items = function(items, event)
    if event == nil then
        return items
    end

    -- 会多一个不是手动传进去的 (*temporary) 的 userdata，地址总是一样的
    -- 所以这里删除最后一个 (*temporary) 元素
    for i = #items, 1, -1 do
        local name = items[i][1]
        if name == '(*temporary)' then
            table.remove(items, i)
            break
        end
    end

    -- event 为 call 时，对于 C 函数来说，(*temporary) 看上去就是函数参数
    -- 改成和 Lua 函数的 (*vararg) 一致
    if event == 'call' or event == 'tail call' then
        for _, item in ipairs(items) do
            local name = item[1]
            if name == '(*temporary)' then
                item[1] = '(*vararg)'
            end
        end
        return items
    end

    -- event 为 return 时，(*temporary) 看上去就是函数返回值
    -- 不过好像判断不了实际返回的个数，实际上 Lua 官方文档也是这么说的
    -- 见 https://cloudwu.github.io/lua53doc/manual.html
    -- lua_sethook() 一节 「没有标准方法来访问被函数返回的那些值。」
    -- 所以这里全部删掉
    if event == 'return' then
        local filtered = {}
        for _, item in ipairs(items) do
            local name = item[1]
            if name ~= '(*temporary)' then
                table.insert(filtered, item)
            end
        end
        return filtered
    end

    -- event 为 line 时，(*temporary) 看上去是没意义的
    -- 所以这里全部删掉
    if event == 'line' then
        local filtered = {}
        for _, item in ipairs(items) do
            local name = item[1]
            if name ~= '(*temporary)' then
                table.insert(filtered, item)
            end
        end
        return filtered
    end

    return items
end

local get_locals_items = function(level)
    local items = {}
    local i

    i = 1
    while true do
        local name, value = rdebug.getlocal(level, i)
        if name == nil then
            break
        end
        table.insert(items, {name, value})
        i = i + 1
    end

    i = -1
    while true do
        local name, value = rdebug.getlocal(level, i)
        if name == nil then
            break
        end
        table.insert(items, {name, value})
        i = i - 1
    end

    return items
end

local get_locals_array = function(level, event)
    local items = get_locals_items(level)
    items = normalize_temporary_items(items, event)
    return aux_common.expand_to_array(items)
end

local get_locals_dict = function(level, event)
    local items = get_locals_items(level)
    items = normalize_temporary_items(items, event)
    return aux_common.expand_to_dict(items)
end

return {
    get_locals_array = get_locals_array,
    get_locals_dict = get_locals_dict,
}
