--[[300f

]]

local G = require "gf"
local t = G.com()

t.prop = 
{
	{name = 'minWidth', type = 'int', ctrl = 'dragint'},
	{name = 'autowidth', type = 'boolean', ctrl = 'boolean'},
}

function t:init()

end
function t:update()
    if self.autowidth then
        local int_width = self.obj.querytextsize(0)
        G.SetObjAttr(self.obj,'width',int_width)
        -- self.obj.width = int_width
    else 
        self.minWidth = self.minWidth or 0
        local minH = self.obj.querytextsize(G.GetObjRealWidth(self.obj))
        if minH < self.minWidth then 
            minH = self.minWidth 
        end 
        G.SetObjAttr(self.obj,'height',minH)
        -- self.obj.height = minH
    end
    
end 
return t