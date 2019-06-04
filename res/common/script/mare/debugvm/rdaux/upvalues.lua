local rdebug = require('remotedebug')
local aux_common = require('mare/debugvm/rdaux/common')

local get_upvalues_items = function(level)
    local items = {}
    local i

    i = 1
    local func = rdebug.getfunc(level)
    while true do
        local name, value = rdebug.getupvalue(func, i)
        if name == nil then
            break
        end

        table.insert(items, {name, value})
        i = i + 1
    end

    return items
end

local get_upvalues_array = function(level)
    local items = get_upvalues_items(level)
    return aux_common.expand_to_array(items)
end

local get_upvalues_dict = function(level)
    local items = get_upvalues_items(level)
    return aux_common.expand_to_dict(items)
end

return {
    get_upvalues_array = get_upvalues_array,
    get_upvalues_dict = get_upvalues_dict,
}
