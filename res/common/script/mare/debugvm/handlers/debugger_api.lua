local lo = require('mare/utils/lodash')
local Sandbox = require('mare/debugvm/core/sandbox').Sandbox
local tabson = require('mare/utils/tabson')

local api = {
    -- luacheck: no unused args

    idling = function(step, session, environ)
        session:heartbeat()
        session:sync()
    end,

    start = function(step, session, environ)
        session:start()
    end,

    stop = function(step, session, environ)
        session:stop()
    end,

    restart = function(step, session, environ)
        session:restart()
    end,

    repl = function(step, session, environ)
        local behavior = session.behavior
        local frontend = session.frontend

        local args = environ:get_locals_array(1, step.event)[1]
        local debug_print = args and args.debug_print
        local fmt = '<replcode>\n%s\n</replcode>'

        local sandbox = Sandbox:new(step, session, environ)
        sandbox.stack_offset = 1
        for _, item in ipairs(behavior.repl_queue) do
            if debug_print then
                print(fmt:format(item.code))
            end

            local ok, value = sandbox:eval(item.code, 2)
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
            frontend:repl(item)
        end

        behavior.repl_queue = {}
    end,

    setopt = function(step, session, environ)
        local args = environ:get_locals_array(1, step.event)
        local key = args[1]
        local value = args[2]
        local item = session.storage[key]
        if not item then
            item = {}
            session.storage[key] = item
        end
        lo.assign(item, value)
    end,

    pause = function(step, session, environ)
        local breakpoint = {
            event = 'return',
            file = step.file,
            line = step.line,
            func = step.func,
        }
        session.behavior:insert_pause_breakpoint(breakpoint, 1)
    end,

    print_behavior = function(step, session, environ)
        print(session.behavior:to_string())
    end,

    -- luacheck: unused args
}

local handle = function(step, session, environ)
    if step.event ~= 'probe' then
        return
    end

    local prefix = '$debugger.'
    if step.name:find(prefix, 1, true) ~= 1 then
        return
    end

    local action = step.name:sub(#prefix + 1)
    local func = api[action]
    if func == nil then
        return
    end
    func(step, session, environ)
end

return {
    name = 'mare.debugger_api',
    handle = handle,
    init_hook_mask = '',
}
