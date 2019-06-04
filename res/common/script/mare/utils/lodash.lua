-- Lodash API 子集实现
-- https://lodash.com/docs/4.17.4

local assign = function(object, ...)
    for _, source in ipairs({...}) do
        for k, v in pairs(source) do
            object[k] = v
        end
    end
    return object
end

local constant = function(value)
    return function() return value end
end

local clone = function(value)
    local copy = {}
    for k, v in pairs(value) do
        copy[k] = v
    end
    return copy
end

return {
    assign = assign,
    constant = constant,
    clone = clone,
}
