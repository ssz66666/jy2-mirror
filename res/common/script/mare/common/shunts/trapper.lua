local class = require('mare/utils/oo').class

local Trapper = class({

    constructor = function(self, props)
        self.state = props.state
    end,

    -- luacheck: no unused args
    match_all = function(self, step)
        -- TODO 其实这里不完全正确，先凑合
        -- 似乎某些异常会触发出以 __ 开头的 C 函数的 return
        local is_c_return = step.event == 'return' and step.scope == 'c'
        local is_metamethod = step.func:find('__', 1, true) == 1
        return is_c_return and is_metamethod
    end,
    -- luacheck: unused args

    match_uncaught = function(self, step)
        -- TODO 处理未在 pcall/xpcall 里运行的
        -- 先跟 all 一样的行为
        return self:match_all(step)
    end,

    match = function(self, step)
        if self.state == 'all' then
            return self:match_all(step)
        end

        if self.state == 'uncaught' then
            return self:match_uncaught(step)
        end

        return false
    end,

    to_string = function(self)
        local fmt = '<Trapper state=%s>'
        return fmt:format(self.state)
    end

})

return {
    Trapper = Trapper,
}
