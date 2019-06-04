--[[3004

]]

local G = require "gf"
local t = G.com()
t.prop = 
{
    -- {name = '菜单标题', type = 'string', ctrl = 'string'},
	{name = '动作编号', type = 'int', ctrl = 'number'},
	{name = '循环播放', type = 'boolean', ctrl = 'boolean'},
}

function t:init()
    
end

function t:set_动作编号()
    if not self.动作编号 then return end
    self.obj.frameActionID(self.动作编号);
end

function t:onFrameEnd(tar, id)
    if self.循环播放 then
        self.obj.frameActionID(self.动作编号);
    end
end
return t