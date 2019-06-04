local tabson = require('mare/utils/tabson')

local handle = function(step, session, environ)
    if step.event ~= 'call' and step.event ~= 'tail call' then
        return
    end

    if step.func ~= 'print' or step.scope ~= 'c' then
        return
    end

    local config = session.storage.pretty_print
    if config and config.mute then
        return
    end

    local stack = environ:get_stack(2)
    local args = environ:get_locals_array(1, step.event)
    local type = (config and config.type) or 'log'

    local values = {}
    for _, v in ipairs(args) do
        local value = tabson.dump(v)
        value.vmtype = 'host'
        table.insert(values, value)
    end

    session.frontend:console_api(values, type, {stack})
end

return {
    name = 'mare.pretty_print',
    handle = handle,
    init_hook_mask = 'c',
}
