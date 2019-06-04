local class = require('mare/utils/oo').class

local Pace = class({

    constructor = function(self, props)
        self.step_type = props.step_type
        self.call_depth = 0
        self.prev_step = nil
    end,

    prev_step_is_return = function(self)
        local step = self.prev_step
        return step and step.is_return
    end,

    prev_step_is_call = function(self)
        local step = self.prev_step
        return step and step.is_call and step.scope ~= 'c'
    end,

    match_over = function(self, step)
        return self.call_depth == 0 and (not step.is_call)
    end,

    -- luacheck: no unused args
    match_out = function(self, step)
        return self.call_depth < 0 and self:prev_step_is_return()
    end,
    -- luacheck: unused args

    match_into = function(self, step)
        if self.call_depth > 0 and self:prev_step_is_call() then
            return true
        end

        -- 不能进入下一层函数时，行为同 over 了
        return self:match_over(step)
    end,

    match = function(self, step)
        -- 忽略进入 C 函数
        if step.is_call and step.scope == 'c' then
            return false
        end

        if self.step_type == 'over' then
            return self:match_over(step)
        end

        if self.step_type == 'out' then
            return self:match_out(step)
        end

        if self.step_type == 'into' then
            return self:match_into(step)
        end

        return false
    end,

    trace = function(self, step)
        local depth = self.call_depth
        if step.is_call then
            depth = depth + 1
        elseif step.is_return then
            depth = depth - 1
        end
        self.prev_step = step
        self.call_depth = depth
    end,

    to_string = function(self)
        local fmt = '<Pace step_type=%s call_depth=%d prev_step.event=%s>'
        local prev_step_event = self.prev_step and self.prev_step.event
        return fmt:format(self.step_type, self.call_depth, prev_step_event)
    end

})

return {
    Pace = Pace,
}
