--[[3002

]]

local G = require "gf"
local t = G.com()
function t:init()
    for i, v in ipairs({'背景', '姓名', '对白'}) do
        self[v] = self.obj.getChildByName(v);
    end
    for i, v in ipairs({'头像', '选项组', '选项模板'}) do
        self[v] = self.背景.getChildByName(v);
    end
    self.选项组content = self.选项组.getChildByName('content')
    self.等待 = self.对白.getChildByName('等待');
    -- self.等待.visible = false;
	if not G.is_editor then
        self.obj.visible = false;
        self.对白.dlgspeed = 50
    end
end
function t:click(tar)
    if self.选项组.visible then
        local id = string.match(tar.name, '选项_(%d+)');
        if id then
            G.trig_event('对话系统_显示选项_结束', tonumber(id));
            self.选项组.visible = false
            self.obj.visible = false;
        end
    elseif self.对白.visible then
        if self.对白.dlgword == 0 then
            G.trig_event('对话系统_显示对话_结束')
            self.obj.visible = false;
        else
            self.对白.dlgword = 0
        end
    end
end
function t:rollOver(tar)
    if self.选项组.visible then
        if string.find(tar.name, '选项_%d+') then
            tar.getChildAt(0).alpha = 128;
        end
    end
end
function t:rollOut(tar)
    if self.选项组.visible then
        if string.find(tar.name, '选项_%d+') then
            tar.getChildAt(0).alpha = 0;
        end
    end
end
function t:update()
	if G.is_editor then
		return
    end
    if self.对白.dlgword == 0 then
        if not (self.等待.visible or self.选项组.visible) then
            self.等待.visible = true;
        end
    end
end
return t