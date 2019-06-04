--[[3035

]]

local G = require "gf"
local t = G.com()
t.prop = 
{
    {name = 'text', type = 'string', ctrl = 'string'},
}

function t:setNumImage()
    self.num2image = {}
    self.num2image[43] = 0x5607000B    --'+'
    self.num2image[45] = 0x5607000C    --'-'
    self.num2image[48] = 0x5607000A    --'0'
    for i=49,57 do  -- 1-9
        self.num2image[i] = 0x56070000 + i - 48
    end 
end

function t:set_text()
    local value = self.text
    self.obj.removeAllChildren()
    if tonumber(value) then 
        if self.num2image==nil then 
            self:setNumImage()
        end 
        local len = string.len(value)
        for i=1,len do 
            local v = string.byte(value,i)
            local img = self.num2image[v]
            if img then 
                local obj = G.Quad()
                obj.anchor = 0x64640000
                obj.name = string.sub(value,i,i)
                obj.img = img
                local w,h = G.imageSize(img)
                obj.width = w
                obj.height = h
                self.obj.addChild(obj)
            end 
        end 
    end 
end 
return t