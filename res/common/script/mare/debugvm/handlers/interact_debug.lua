local class = require('mare/utils/oo').class
local tabson = require('mare/utils/tabson')
local Sandbox = require('mare/debugvm/core/sandbox').Sandbox

local Interacter = class({

    constructor = function(self, step, session, environ)
        self.step = step
        self.session = session
        self.environ = environ
        self.sandbox = nil
    end,

    eval_code = function(self, code, level)
        if not self.sandbox then
            self.sandbox = Sandbox:new(self.step, self.session, self.environ)
        end
        return self.sandbox:eval(code, level)
    end,

    match_cond = function(self, shunt)
        local cond = shunt.cond
        if (not cond) or cond == '' then
            return true
        end
        local ok, value = self:eval_code(cond, 1)
        return ok and value
    end,

    is_need_skip = function(self)
        local step = self.step
        local behavior = self.session.behavior
        local shunt

        shunt = behavior:match_skip_situation(step)
        if shunt then
            return shunt
        end

        shunt = behavior:match_skip_blackbox(step)
        if shunt then
            return shunt
        end

        return nil
    end,

    is_need_pause = function(self)
        local step = self.step
        local behavior = self.session.behavior
        local shunt

        shunt = behavior:match_pause_breakpoint(step)
        if shunt and self:match_cond(shunt) then
            return shunt
        end

        shunt = behavior:match_pause_trapper(step)
        if shunt and self:match_cond(shunt) then
            return shunt
        end

        shunt = behavior:match_pause_pace(step)
        if shunt and self:match_cond(shunt) then
            return shunt
        end

        return nil
    end,

    process_scope_queue = function(self)
        local event = self.step.event
        local behavior = self.session.behavior
        local frontend = self.session.frontend
        local environ = self.environ

        for _, item in ipairs(behavior.scope_queue) do
            local value
            if item.type == 'locals' then
                value = environ:get_locals_dict(item.level, event)
            elseif item.type == 'upvalues' then
                value = environ:get_upvalues_dict(item.level, event)
            else
                value = {}
            end

            local args = {}
            for k, v in pairs(value) do
                local dumped = tabson.dump(v)
                dumped.vmtype = 'host'
                args[k] = dumped
            end
            item.value = args
            frontend:stack_scope(item)
        end

        behavior.scope_queue = {}
    end,

    process_watch_queue = function(self)
        local behavior = self.session.behavior
        local frontend = self.session.frontend

        for _, item in ipairs(behavior.watch_queue) do
            local ok, value = self:eval_code(item.code, item.level)
            item.error = not ok

            local value_type = type(value)
            item.value = tabson.dump(value)
            item.value.vmtype = 'sandbox'
            if value_type == 'table' then
                local mt = getmetatable(value);
                if mt and mt.__HOST_OBJ__ then
                    item.value.vmtype = 'host'
                end
            end
            frontend:stack_watch(item)
        end

        behavior.watch_queue = {}
    end,

    trace_step = function(self)
        self.session.behavior:trace_step(self.step)
    end,

    loop = function(self)
        local environ = self.environ
        local session = self.session
        local behavior = session.behavior
        local frontend = session.frontend

        --print(self.behavior:to_string())
        local stacks = environ:get_stacks()
        behavior:execute_pause(stacks)
        frontend:execute_paused(stacks, self.step)

        while behavior:is_pausing() do
            if not session:is_ready() then
                break
            end

            session:sync(0.1)
            self:process_scope_queue()
            self:process_watch_queue()
        end

        frontend:execute_resumed()
    end,

    require_mask = function(self)
        local behavior = self.session.behavior

        local chars = {}

        for _, breakpoint in ipairs(behavior.pause_breakpoints) do
            local event = breakpoint.event
            if event == 'call' or event == 'tail call' then
                chars.c = true
            elseif event == 'return' then
                chars.r = true
            elseif event == 'line' then
                chars.l = true
            end
        end

        if behavior.pause_pace then
            chars.l = true
            chars.c = true
            chars.r = true
        end

        if behavior.pause_trapper then
            chars.r = true
        end

        local mask = ''
        for k, _ in pairs(chars) do
            mask = mask .. k
        end
        self.environ:require_mask(mask)
    end,
})

local handle = function(step, session, environ)
    local interacter = Interacter:new(step, session, environ)

    local skip_shunt = interacter:is_need_skip()
    if skip_shunt then
        --print(environ.aux.format_step(step), 'SKIP')
        interacter:require_mask()
        return
    end

    local pause_shunt = interacter:is_need_pause()
    if not pause_shunt then
        interacter:trace_step()
        interacter:require_mask()
        return
    end

    --print(environ.aux.format_step(step), 'PAUSE')
    --print(pause_shunt:to_string())
    interacter:loop()
    interacter:require_mask()
end

return {
    name = 'mare.interact_debug',
    handle = handle,
    init_hook_mask = '',
}
