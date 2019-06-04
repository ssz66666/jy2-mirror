local rdebug = require('remotedebug')

local is_c_inner_frame = function(frame)
    return frame.what == 'C' and frame.namewhat == ''
end

local is_c_frame = function(frame)
    return frame.what == 'C' and frame.namewhat ~= ''
end

local get_frame = function(level)
    return rdebug.getinfo(level)
end

local normalize_frame = function(frame)
    local name = frame.name
    if name == nil then
        if frame.what == 'main' then
            name = '(main)'
        elseif frame.what == 'Lua' then
            name = '(noname)'
        end
    end

    return {
        file = frame.source,
        line = frame.currentline,
        func = name,
    }
end

return {
    is_c_inner_frame = is_c_inner_frame,
    is_c_frame = is_c_frame,
    get_frame = get_frame,
    normalize_frame = normalize_frame,
}
