--[[3009

]]

local G = require "gf"
local t = G.com()

t.prop = 
{
    {name = '阴影偏移X',	type = 'int', ctrl = 'dragint', ctrl_arg = { min = -255, max = 255} },
	{name = '阴影偏移Y',	type = 'int', ctrl = 'dragint', ctrl_arg = { min = -255, max = 255} },
	{name = '阴影透明度',	type = 'int', ctrl = 'dragint', ctrl_arg = { max = 255} },
	{name = '阴影风格',	type = 'hex', ctrl = 'color'},
}

function t:init()
    self:set_阴影偏移X()
    self:set_阴影偏移Y()
    self:set_阴影透明度()
    self:set_阴影风格()
end

function t:set_阴影偏移X()
    if self.阴影偏移X then
        self.obj.shadowX = self.阴影偏移X
    end
end
function t:set_阴影偏移Y()
    if self.阴影偏移Y then
        self.obj.shadowY = self.阴影偏移Y
    end
end
function t:set_阴影透明度()
    if self.阴影透明度 then
        self.obj.shadowAlpha = self.阴影透明度
    end
end
function t:set_阴影风格()
    if self.阴影风格 then
        self.obj.shadowStyle = self.阴影风格
    end
end
return t