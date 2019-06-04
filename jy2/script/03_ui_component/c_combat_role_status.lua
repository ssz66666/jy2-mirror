--[[3005

]]

local G = require "gf"
local t = G.com()

t.prop = 
{
    {name = "生命", type = 'int', ctrl = 'dragint', ctrl_arg = {min = 0, max = 9999}},
    {name = "生命上限", type = 'int', ctrl = 'dragint', ctrl_arg = {min = 0, max = 9999}},
    {name = "内力", type = 'int', ctrl = 'dragint', ctrl_arg = {min = 0, max = 9999}},
    {name = "内力上限", type = 'int', ctrl = 'dragint', ctrl_arg = {min = 0, max = 9999}},
    {name = "集气比例", type = 'number', ctrl = 'dragfloat', ctrl_arg = {min = 0, max = 1, step = 0.01}},
}

function t:init()
    for i, v in ipairs({'头像', '背景'}) do
        self[v] = self.obj.getChildByName(v);
    end
    self.生命条 = self.背景.getChildAt(0)
    self.内力条 = self.背景.getChildAt(1)
    self.生命数值 = self.生命条.getChildAt(0)
    self.内力数值 = self.内力条.getChildAt(0)
end

function t:更新生命条()
    if self.生命 ~= nil and self.生命上限 ~= nil then
        local percent;
        if self.生命上限 > 0 then
            percent = self.生命 / self.生命上限;
        else
            percent = 0;
        end
        if percent > 1 then
            percent = 1;
        elseif percent < 0 then
            percent = 0;
        end
        self.生命条.width = 176 * percent;
        self.生命数值.text = string.format('%5d/%-5d', math.floor(self.生命), math.floor(self.生命上限));
    end
end

function t:更新内力条()
    if self.内力 ~= nil and self.内力上限 ~= nil then
        local percent;
        if self.内力上限 > 0 then
            percent = self.内力 / self.内力上限;
        else
            percent = 0;
        end
        if percent > 1 then
            percent = 1;
        elseif percent < 0 then
            percent = 0;
        end
        self.内力条.width = 176 * percent;
        self.内力数值.text = string.format('%5d/%-5d', math.floor(self.内力), math.floor(self.内力上限));
    end
end

function t:set_生命()
    self:更新生命条()
end
function t:set_生命上限()
    self:更新生命条()
end
function t:set_内力()
    self:更新内力条()
end
function t:set_内力上限()
    self:更新内力条()
end
return t