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
   {name = 'isErase', type = 'boolean', ctrl = 'boolean'},
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
function t:set_isErase(value)
	if self.isErase == true then
		if self.fill then
			self.fill.imgX = 0
			self.fill.imgY = 0
		end
	else
		if self.fill then
			self.fill.imgX = 127
			self.fill.imgY = 127
		end
	end
end
function t:set_Percent(value)
	if self.Percent == 0 then
		self.fill.visible = false
	else
		self.fill.visible = true
	end
	if self.Percent > 100 then self.Percent = 100 end 
	if self.Percent < 0 then self.Percent = 0 end 
	
	if self.Direction == nil or self.Direction == 0 then 
		self.fill.anchorR = self.Percent/100
	elseif self.Direction == 1 then  
		self.fill.anchorL = self.Percent/100
	end
	if self.isErase == true then
		if self.handle then		-- 这里是针对登录界面的handle做的，可能有点特殊。
			self.handle.x = -self.obj.width * (1 - self.Percent/100) - 8
		end
	end
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