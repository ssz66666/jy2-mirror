-- 字符串处理工具

local split = function(str, sep)
    local fields = {}
    local pattern = string.format('([^%s]+)', sep)
    string.gsub(str, pattern, function(c)
        table.insert(fields, c)
    end)
    return fields
end

local urlencode = function(query)
    local items = {}
    for k, v in pairs(query) do
        table.insert(items, string.format('%s=%s', k, v))
    end
    return table.concat(items, '&')
end

local uniqchars = function(chars)
    local result = ''
    for i = 1, #chars + 1 do
        local char = chars:sub(i, i)
        if not result:find(char, 1, true) then
            result = result .. char
        end
    end
    return result
end

return {
    split = split,
    urlencode = urlencode,
    uniqchars = uniqchars,
}
