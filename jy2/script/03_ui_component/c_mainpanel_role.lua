--[[3001

]]

local G = require "gf"
local t = G.com()
function t:init()
    self.属性列表 = {'姓名', '门派', '称号', '等级', 
                    '生命', '生命上限', '内力', '内力上限', 
                    '福缘', '悟性', '护体', '拳掌', 
                    '暗器', '用毒', '声望', '力道', 
                    '身法', '御剑', '医疗', '解毒', '银两'
                }
    for i, v in ipairs(self.属性列表) do
        self[v] = self.obj.getChildByName(v);
    end
    self.关闭 = self.obj.getChildByName('关闭');
end
function t:setData(o_role_主角)
    for i, v in ipairs(self.属性列表) do
        if self[v] ~= nil then
            if o_role_主角[v .. '1'] ~= nil then
                self[v].text = o_role_主角[v .. '1'];
            elseif o_role_主角[v] ~= nil then
                self[v].text = o_role_主角[v];
            end
        end
    end
    self.obj.visible = true;
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