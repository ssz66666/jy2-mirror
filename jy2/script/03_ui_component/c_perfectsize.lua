--[[3010

]]

local G = require "gf"
local t = G.com()
t.prop = 
{
    {name = 'height', type = 'boolean', ctrl = 'boolean'},
    {name = 'expheight', type = 'int', ctrl = 'dragint'},
    {name = 'minheight', type = 'int', ctrl = 'dragint'},
    {name = 'width', type = 'boolean', ctrl = 'boolean'},
    {name = 'expwidth', type = 'int', ctrl = 'dragint'},
    {name = 'minwidth', type = 'int', ctrl = 'dragint'},
}
function t:boundUpdated()
    if self.height then 
        self.expheight = self.expheight or 0
        local maxHeight = 0
        for i=1,self.obj.childCount do
            local child = self.obj.getChildAt(i-1) 
            if child.visible then 
                local height = G.GetObjRealHeight(child) - child.y
                if height > maxHeight then 
                    maxHeight = height
                end 
            end
        end 
        if self.minheight and maxHeight < self.minheight then 
            maxHeight = self.minheight
        end 
        G.SetObjAttr(self.obj,'height',maxHeight+self.expheight)
        --self.obj.height = maxHeight+self.expheight
    end 
    if self.width then 
        self.expwidth = self.expwidth or 0
        local maxWidth = 0
        for i=1,self.obj.childCount do
            local child = self.obj.getChildAt(i-1) 
            if child.visible then 
                local width = G.GetObjRealWidth(child) + child.x
                if width > maxWidth then 
                    maxWidth = width
                end 
            end
        end 
        if self.minwidth and maxWidth < self.minwidth then 
            maxWidth = self.minwidth
        end 
        G.SetObjAttr(self.obj,'width',maxWidth+self.expwidth)
        --self.obj.width = maxWidth+self.expwidth
    end 
end
return t