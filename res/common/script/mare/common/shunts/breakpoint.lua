local class = require('mare/utils/oo').class
local libpath = require('mare/utils/path')

local Breakpoint = class({

    constructor = function(self, props)
        self.event = props.event
        self.file = props.file
        self.line = props.line
        self.func = props.func
        self.name = props.name
        self.cond = props.cond
    end,

    match_line = function(self, step)
        local same_file = libpath.is_same_source(step.file, self.file)
        local same_line = step.line == self.line
        return same_file and same_line
    end,

    match_call = function(self, step)
        local same_file = libpath.is_same_source(step.file, self.file)
        local same_line = step.line == self.line
        local same_func = step.func == self.func
        return same_file and same_line and same_func
    end,

    match_tailcall = function(self, step)
        local same_file = libpath.is_same_source(step.file, self.file)
        local same_line = step.line == self.line
        return same_file and same_line
    end,

    match_return = function(self, step)
        local same_file = libpath.is_same_source(step.file, self.file)
        local same_line = step.line == self.line
        local same_func = step.func == self.func
        return same_file and same_line and same_func
    end,

    match_probe = function(self, step)
        -- 以 $ 开头作内部用途，有特殊意义，忽略
        if step.name:find('$', 1, true) == 1 then
            return false
        end

        local same_name = step.name == self.name
        return same_name
    end,

    match = function(self, step)
        if self.event ~= step.event then
            return false
        end

        if self.event == 'line' then
            return self:match_line(step)
        end

        if self.event == 'call' then
            return self:match_call(step)
        end

        if self.event == 'tail call' then
            return self:match_tailcall(step)
        end

        if self.event == 'return' then
            return self:match_return(step)
        end

        if self.event == 'probe' then
            return self:match_probe(step)
        end

        return false
    end,

    to_string = function(self)
        local names = {'event', 'file', 'line', 'func', 'name'}
        local attrs = {}
        for _, name in ipairs(names) do
            local attr = self[name]
            if self[name] then
                table.insert(attrs, string.format('%s=%s', name, attr))
            end
        end
        if self.cond then
            table.insert(attrs, string.format('cond=%q', self.cond))
        end
        local fmt = '<Breakpoint %s>'
        return fmt:format(table.concat(attrs, ' '))
    end
})

return {
    Breakpoint = Breakpoint,
}
