--[[3001

]]

local G = require "gf"
local t = G.com()
function t:init()
    for i, v in ipairs({'网格', '说明', '卸兵', '卸甲', '关闭'}) do
        self[v] = self.obj.getChildByName(v);
    end
end
function t:click(tar)
    if tar == self.关闭 then
        self.obj.visible = false;
        if self.obj.parent then
            local c = self.obj.parent.c_mainpanel
            if c then
                c.透明遮挡.visible = false
            end
        end
    end
end
return t