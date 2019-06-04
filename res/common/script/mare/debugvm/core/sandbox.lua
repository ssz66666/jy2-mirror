local lo = require('mare/utils/lodash')
local class = require('mare/utils/oo').class
local mirage = require('mare/utils/mirage')
local tabson = require('mare/utils/tabson')

local create_console = function(impl)
    local alias = {
        warn = 'warning',
        group = 'startGroup',
        group_collapsed = 'startGroupCollapsed',
        group_end = 'endGroup'
    }
    local mt = {
        -- luacheck: no unused args
        __index = function(t, k)
            return function(...) impl(alias[k] or k, ...) end
        end,
        -- luacheck: unused args
    }
    return setmetatable({}, mt)
end

local Sandbox = class({

    constructor = function(self, step, session, environ)
        self.step = step
        self.session = session
        self.environ = environ
        self.stack_offset = 0
        self.envs = {}
    end,

    get_injects = function(self)
        local frontend = self.session.frontend
        local storage = self.session.storage
        local stacks = self.environ:get_stacks()
        for _ = 1, self.stack_offset do
            table.remove(stacks, 1)
        end

        local pp_config = storage.pretty_print
        local pp_type = (pp_config and pp_config.type) or 'log'

        return {
            print = function(...)
                local values = {}
                for _, v in ipairs({...}) do
                    local value_type = type(v)
                    local value = tabson.dump(v)
                    value.vmtype = 'sandbox'
                    if value_type == 'table' then
                        local mt = getmetatable(v);
                        if mt and mt.__HOST_OBJ__ then
                            value.vmtype = 'host'
                        end
                    end
                    table.insert(values, value)
                end

                frontend:console_api(values, pp_type, stacks)
            end,
            console = create_console(function(console_type, ...)
                local values = {}
                for _, v in ipairs({...}) do
                    local value_type = type(v)
                    local value = tabson.dump(v)
                    value.vmtype = 'sandbox'
                    if value_type == 'table' then
                        local mt = getmetatable(v);
                        if mt and mt.__HOST_OBJ__ then
                            value.vmtype = 'host'
                        end
                    end
                    table.insert(values, value)
                end

                frontend:console_api(values, console_type, stacks)
            end),
        }
    end,

    get_env = function(self, level)
        local env = self.envs[level]
        if env then
            return env
        end

        local event = self.step.event
        local environ = self.environ
        local locals = environ:get_locals_dict(level, event)
        local upvalues = environ:get_upvalues_dict(level, event)
        local injects = self:get_injects()
        local fallback = {_MARE=injects}
        env = lo.assign({}, mirage, injects, upvalues, locals, fallback)

        self.envs[level] = env
        return env
    end,

    eval = function(self, code, level)
        if code == 'true' then
            return true, true
        end
        if code == 'false' then
            return true, false
        end

        local chunk_name = 'eval'
        local env = self:get_env(level)
        local ok, value = pcall(function()
            local func = load(code, chunk_name, 't', env)
            if not func then
                code = 'return ' .. code
                func = load(code, chunk_name, 't', env)
            end

            -- TODO func() 执行如果出错，会在下一次调用时出现
            -- debugger error: ./mare/debugvm/rdaux/frame.lua:12: Must call in debug client
            return func()
        end)
        if type(value) == 'string' then
            local find = '%g/mare/debugvm/core/sandbox.lua:%d+: '
            value = value:gsub(find, '')
        end
        return ok, value
    end,
});

return {
    Sandbox = Sandbox,
}
