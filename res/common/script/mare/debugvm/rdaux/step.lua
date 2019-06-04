local aux_frame = require('mare/debugvm/rdaux/frame')

local get_step = function(event)
    local frame = aux_frame.get_frame(1)
    local step
    if aux_frame.is_c_frame(frame) then
        local frame2 = aux_frame.get_frame(2)
        step = aux_frame.normalize_frame(frame2)
        step.func = frame.name
        step.scope = 'c'
    else
        step = aux_frame.normalize_frame(frame)
        step.scope = 'lua'
    end

    if event == 'line' or event == 'call'
        or event == 'tail call'
        or event == 'return' then
        step.event = event
    else
        step.event = 'probe'
        step.name = event
    end

    step.is_line = event == 'line'
    step.is_call = event == 'call' or event == 'tail call'
    step.is_return = event == 'return'
    step.is_probe = event == 'probe'
    return step
end

return {
    get_step = get_step,
}
