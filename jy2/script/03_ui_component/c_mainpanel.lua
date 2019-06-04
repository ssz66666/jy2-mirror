--[[3007

]]

local G = require "gf"
local t = G.com()
function t:init()
    for i, v in ipairs({'透明遮挡', '人物界面', '武功界面', '物品界面', '秘籍界面', '存档界面'}) do
        self[v] = self.obj.getChildByName(v);
        if not G.is_editor then
            self[v].visible = false;
        end
    end
end
return t