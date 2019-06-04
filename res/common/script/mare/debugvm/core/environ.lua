local class = require('mare/utils/oo').class
local aux = require('mare/debugvm/rdaux')

local Environ = class({

    constructor = function(self)
        self.aux = aux
        self.locals_array_cache = {}
        self.locals_dict_cache = {}
        self.require_mask_name = nil
        self.require_mask_dict = nil
    end,

    get_locals_array = function(self, level, event)
        local key = string.format('%s:%d', event, level)
        local value = self.locals_array_cache[key]
        if value ~= nil then
            return value or nil
        end

        value = aux.get_locals_array(level, event)
        self.locals_array_cache[key] = value or false
        return value
    end,

    get_locals_dict = function(self, level, event)
        local key = string.format('%s:%d', event, level)
        local value = self.locals_dict_cache[key]
        if value ~= nil then
            return value or nil
        end

        value = aux.get_locals_dict(level, event)
        self.locals_dict_cache[key] = value or false
        return value
    end,

    -- luacheck: no unused args
    get_upvalues_dict = function(self, level)
        return aux.get_upvalues_dict(level)
    end,

    get_step = function(self, event)
        return aux.get_step(event)
    end,

    get_stack = function(self, level)
        return aux.get_stack(level)
    end,
    -- luacheck: unused args

    get_stacks = function(self)
        local stacks = {}
        local i = 1
        while true do
            local stack = self:get_stack(i)
            if stack == nil then
                break
            end
            table.insert(stacks, stack)
            i = i + 1
        end
        return stacks
    end,

    require_mask = function(self, mask)
        local name = self.require_mask_name
        local dict = self.require_mask_dict
        if mask and name and dict then
            dict[name] = mask
        end
    end,

})

return {
    Environ = Environ,
}
