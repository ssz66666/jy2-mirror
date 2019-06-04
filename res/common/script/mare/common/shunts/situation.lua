local class = require('mare/utils/oo').class

local Situation = class({

    constructor = function(self, props)
        self.state = props.state
    end,

    -- luacheck: no unused args
    match_always = function(self, step)
        return true
    end,
    -- luacheck: unused args

    match = function(self, step)
        if self.state == 'always' then
            return self:match_always(step)
        end
        return false
    end,

    to_string = function(self)
        local fmt = '<Situation state=%s>'
        return fmt:format(self.state)
    end

})

return {
    Situation = Situation,
}
