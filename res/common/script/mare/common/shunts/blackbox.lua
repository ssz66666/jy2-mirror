local class = require('mare/utils/oo').class
local libpath = require('mare/utils/path')

local Blackbox = class({

    constructor = function(self, props)
        self.file = props.file
        self.start_line = props.start_line
        self.end_line = props.end_line
    end,

    match = function(self, step)
        if not libpath.is_same_source(self.file, step.file) then
            return false
        end

        if self.start_line ~= 0 and self.start_line > step.line then
            return false
        end

        if self.end_line ~= 0 and self.end_line < step.line then
            return false
        end

        return true
    end,

    to_string = function(self)
        local fmt = '<Blackbox file=%s start_line=%d end_line=%d>'
        return fmt:format(self.file, self.start_line, self.end_line)
    end

})

return {
    Blackbox = Blackbox,
}
