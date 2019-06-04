--[[3011

]]

local G = require "gf"
local t = G.com()
function t:init()
    self.序列帧动画 = self.obj.getChildByName('序列帧动画')
end

function t:setData(o_animation_name)
    local info = o_animation_name
    self.序列帧动画.img = 0x33010000 | (info.name&0x0000ffff)
    if o_animation_name.图像 and o_animation_name.图像[1] then
        local w,h = G.imageSize(o_animation_name.图像[1])
        self.序列帧动画.width = w
        self.序列帧动画.height = h
    end
end
return t