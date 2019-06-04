-- 过滤掉 IO 功能的 Lua 沙盒环境

local whitelist = {}

local basic_names = {
    '_VERSION',
    'assert',
    'error',
    'getmetatable',
    'ipairs',
    'next',
    'pairs',
    'pcall',
    'rawequal',
    'rawget',
    'rawlen',
    'rawset',
    'select',
    'setmetatable',
    'tonumber',
    'tostring',
    'type',
    'xpcall',
}

local os_names = {
    'clock',
    'date',
    'difftime',
    'time',
}

for _, name in ipairs(basic_names) do
    whitelist[name] = _ENV[name]
end

whitelist.os = {}
for _, name in ipairs(os_names) do
    whitelist.os[name] = _ENV.os[name]
end

whitelist.math = _ENV.math
whitelist.string = _ENV.string
whitelist.table = _ENV.table
whitelist.utf8 = _ENV.utf8

return whitelist
