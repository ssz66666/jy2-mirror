-- 简单粗暴的面向对象实现

local new = function(cls, ...)
    local self = {}
    setmetatable(self, cls)
    cls.__index = cls
    cls.constructor(self, ...)
    return self
end

local class = function(body)
    body.new = new;
    return body;
end

return {
    class = class,
}
