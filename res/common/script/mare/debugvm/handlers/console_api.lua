local tabson = require('mare/utils/tabson')

local handle = function(step, session, environ)
    if step.event ~= 'probe' then
        return
    end

    local prefix = '$console.'
    if step.name:find(prefix, 1, true) ~= 1 then
        return
    end

    local type = step.name:sub(#prefix + 1)
    local args = environ:get_locals_array(1, step.event)
    local stacks = environ:get_stacks()

    local values = {}
    for _, v in ipairs(args) do
        local value = tabson.dump(v)
        value.vmtype = 'host'
        table.insert(values, value)
    end

    session.frontend:console_api(values, type, stacks);
end

return {
    name = 'mare.console_api',
    handle = handle,
    init_hook_mask = '',
}
