--[[3002

]]

local G = require "gf"
local t = G.com()
function t:init()
    for i, v in ipairs({'提示框', '输入框', '全屏字幕', '按钮模板', '飘字', '等级上升', '右下', '右上', '左上', '左下'}) do
        self[v] = self.obj.getChildByName(v);
    end
    for i, v in ipairs({'标题', '提示', '等待', '按钮组'}) do
        self[v] = self.提示框.getChildByName(v);
    end
    self.输入框标题 =  self.输入框.getChildByName('标题')
    self.输入框输入 =  self.输入框.getChildByName('输入')
    self.输入框字数限制 = 5
    self.输入框确定 =  self.输入框.getChildByName('确定')
    self.全屏字幕文本 =  self.全屏字幕.getChildByName('文本')
    self.全屏字幕等待 =  self.全屏字幕文本.getChildByName('等待')
	if not G.is_editor then
        self.obj.visible = false;
        self.提示框.visible = false;
        self.输入框.visible = false;
        self.全屏字幕.visible = false;
        self.飘字.visible = false;
        self.等级上升.visible = false;
        self.全屏字幕.visible = false;
    end
end
--ret=string
function t:cutString()
    local string_输入 = self.输入框输入.text
    if G.getStrLen(string_输入) > self.输入框字数限制 then
        self.输入框输入.text = G.utf8sub(string_输入, 1, self.输入框字数限制)
    end
end
function t:update()
    if (not G.is_editor) and self.输入框.visible then
        self:cutString();
    end
end
function t:click(tar)
    if self.提示框.visible and self.等待.visible then
        G.trig_event('通知系统_显示系统提示_结束')
        self.提示框.visible = false;
    elseif tar.parent == self.按钮组 and tar.c_button ~= nil then
        G.trig_event('通知系统_显示系统提示_结束', tar.c_button.text)
        self.提示框.visible = false;
    elseif tar == self.输入框确定 then
        if G.getStrLen(self.输入框输入.text) >= 1 then
            G.trig_event('通知系统_显示输入框_结束', self.输入框输入.text)
            self.输入框.visible = false;
        end
    elseif self.全屏字幕.visible and self.全屏字幕等待.visible then
        G.trig_event('通知系统_显示全屏字幕_结束')
        self.全屏字幕.visible = false;
    end
end
return t