--[[3104
,
]]
local G = require("gf")

local t = G.com()

t.prop = 
{
   {name = "Percent", type = 'int', ctrl = 'dragint', ctrl_arg = {min = 0, max = 100}},
   {name = 'Direction', type = 'int', ctrl = 'combo_idx', ctrl_arg = {'Left To Right', 'Right To Left', 'Bottom To Top', 'Top To Bottom'}},
   {name = 'Background', type = 'hex', ctrl = 'image'},
   {name = 'Fill', type = 'hex', ctrl = 'image'},
   {name = 'Handle', type = 'hex', ctrl = 'image'},
}

function t:init()
	self.handle = self.obj.getChildByName('Handle')
	self.fill = self.obj.getChildByName('Fill')
	self.background = self.obj.getChildByName('Background')

	self.obj.mouseEnabled = true
	if self.handle then 
		self.handle.mouseEnabled = true
	end 
	self.drag = nil
	self.Percent = self.Percent or 0
end
function t:set_Background(value)
	self.background.img = self.Background
end 
function t:set_Fill(value)
	self.fill.img = self.Fill
end 
function t:set_Percent(value)
	if self.Percent == 0 then
		self.fill.visible = false
	else
		self.fill.visible = true
	end
	self.fill.anchorR = self.Percent/100
end 

function t:rollOut(tar)
	if tar == self.obj then
		self.drag = nil
	end
end

function t:mouseUp(tar)
	self.drag = nil
end

function t:mouseDown(tar)
	if self.handle and tar == self.handle then
		self.drag = self.cur
	end
end

-------------------------------------
-- 根据移动的偏移量设置滑动节点的位置
function t:setHandlePosition(deltaX, deltaY)
	if self.handle then
		self.handle.x = self.handle.x - deltaX
	end 
	self.fill.width = self.fill.width - deltaX
end

return t