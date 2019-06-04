--[[300a

]]

local G = require "gf"
local t = G.com()
function t:init()
    self.背景 = self.obj.getChildByName('背景');
    for i, v in ipairs({"列表", "离开", "银两", "选项模板"}) do
        self[v] = self.背景.getChildByName(v);
    end
    self.列表content = self.列表.getChildByName('content')
end
function t:click(tar)
    local id = string.match(tar.name, '选项_(%d+)');
    if id then
        G.trig_event('商店系统_显示商品_结束', tonumber(id));
        self.obj.visible = false;
    elseif tar == self.离开 then
        G.trig_event('商店系统_显示商品_结束', 0);
        self.obj.visible = false;
    end
end
function t:rollOver(tar)
    local ui = tar.getChildAt(0);
    if ui and ui.name == '背景' then
        ui.visible = true;
    end
end
function t:rollOut(tar)
    local ui = tar.getChildAt(0);
    if ui and ui.name == '背景' then
        ui.visible = false;
    end
end
return t