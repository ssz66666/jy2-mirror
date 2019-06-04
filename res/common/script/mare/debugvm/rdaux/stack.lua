local aux_frame = require('mare/debugvm/rdaux/frame')

local get_stack = function(level)
    local frame = aux_frame.get_frame(level)

    if frame == nil then
        return nil
    end

    if aux_frame.is_c_inner_frame(frame) then
        return nil
    end

    local stack = aux_frame.normalize_frame(frame)
    return stack
end

return {
    get_stack = get_stack,
}
