-- 路径处理工具

local sep = package.config:sub(1, 1)

local posixify_source = function(path)
    -- 全部替换成正斜杠，连续多个就合并成一个
    -- 去掉标识当前目录的相对路径前缀
    return path:gsub('[\\/]+', '/'):gsub('^@./', '@')
end

local is_same_source = function(path1, path2)
    -- 先简单判断下是否完全相同
    if path1 == path2 then
        return true
    end
    return posixify_source(path1) == posixify_source(path2)
end

return {
    sep = sep,
    posixify_source = posixify_source,
    is_same_source = is_same_source,
}
