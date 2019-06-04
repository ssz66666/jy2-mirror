local lo = require('mare/utils/lodash')
local libstr = require('mare/utils/string')
local class = require('mare/utils/oo').class
local aux = require('mare/debugvm/rdaux')
local Session = require('mare/debugvm/core/session').Session
local Environ = require('mare/debugvm/core/environ').Environ

local builtin_handlers = {
    require('mare/debugvm/handlers/debugger_api'),
    require('mare/debugvm/handlers/interact_debug'),
    require('mare/debugvm/handlers/pretty_print'),
    require('mare/debugvm/handlers/console_api'),
}

local Debugger = class({

    constructor = function(self, config, IOStream)
        self.config = config
        self:init_session(IOStream)
        self:init_handlers()
        self:init_require_mask_dict()
        self:init_mask()
    end,

    init_session = function(self, IOStream)
        local config = self.config
        local iostream = IOStream:new(config.iostream)
        self.session = Session:new(config.session, iostream)
    end,

    init_handlers = function(self)
        self.handlers = lo.clone(builtin_handlers)
    end,

    init_require_mask_dict = function(self)
        local dict = {}
        for _, handler in ipairs(self.handlers) do
            dict[handler.name] = handler.init_hook_mask
        end
        self.require_mask_dict = dict
    end,

    init_mask = function(self)
        local concat = self:flat_require_mask_dict()
        if self.config.pause_on_start then
            concat = concat .. 'r'
        end
        self.mask = libstr.uniqchars(concat)
    end,

    start = function(self)
        local config = self.config
        local session = self.session
        local behavior = session.behavior

        session:start()
        if config.pause_on_start then
            local step = aux.get_step()
            local breakpoint = {
                event = 'return',
                func = 'start',
                file = step.file,
                line = step.line,
            }
            behavior:insert_pause_breakpoint(breakpoint, 1)
        end
    end,

    hook = function(self, event)
        local frame = aux.get_frame(1)
        --aux.print_frame(frame, event)
        if aux.is_c_inner_frame(frame) then
            return
        end

        local environ = Environ:new()
        local step = environ:get_step(event)
        --aux.print_step(step)

        local session = self.session
        local handlers = self.handlers
        environ.require_mask_dict = self.require_mask_dict

        session:sync()
        for _, handler in ipairs(handlers) do
            environ.require_mask_name = handler.name
            handler.handle(step, session, environ)
        end

        self.mask = self:flat_require_mask_dict()
    end,

    flat_require_mask_dict = function(self)
        local mask = ''
        for _, v in pairs(self.require_mask_dict) do
            mask = mask .. v
        end
        return libstr.uniqchars(mask)
    end,

    get_host_args = function()
        return aux.get_locals_array(0)
    end,
})

return {
    Debugger = Debugger,
}
