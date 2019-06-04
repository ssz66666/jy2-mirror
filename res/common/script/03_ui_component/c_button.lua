--[[3101
,
]]
local G = require 'gf'

local t = G.com()

t.prop =
{
	{name = 'text', type = 'string', ctrl = 'string'},
	{name = 'btn_class',	type = 'int', ctrl = 'combo_idx', ctrl_arg = { '普通',  '单选框'} },
	{name = "customsize",type = 'boolean',ctrl = 'boolean'},
	{name = "img_normal",type = 'hex',ctrl = 'image'},
	{name = "color_normal",type = 'hex',ctrl = 'color'},
	{name = "img_hover",type = 'hex',ctrl = 'image'},
	{name = "color_hover",type = 'hex',ctrl = 'color'},
	{name = "audio_hover",type = 'hex',ctrl = 'audio'},
	{name = "img_press",type = 'hex',ctrl = 'image'},
	{name = "frameList_press",type = 'hex',ctrl = 'image'},
	{name = "color_press",type = 'hex',ctrl = 'color'},
	{name = "audio_press",type = 'hex',ctrl = 'audio'},
	{name = "img_disable",type = 'hex',ctrl = 'image'},
	{name = "color_disable",type = 'hex',ctrl = 'color'},
	{name = "img_toggle",type = 'hex',ctrl = 'image'},
	{name = "color_toggle",type = 'hex',ctrl = 'color'},
	{name = "img_togEx",type = 'hex',ctrl = 'image'},
}

function t:init()
	self.state = 'n'
	self:setImage(self.state)
	self.down = 1
end

function t:update()
	-- 是否有外部点击
	if G.MouseState() == 1 then
		if self.state ~= 'p' then
			self.down = 1
		end
	end
end

function t:rollOver(tar)
	self.down = self.down + 1
	if tar ~= self.obj then return end 
	if self.state == 'c' then 
		return 
	end
	if self.state ~= 'd' then
		if G.MouseState() == 0 then
			self.state = 'p'
		else
			self.state = 'h'
		end
	end
end

function t:rollOut(tar)
	self.down = self.down - 1
	if tar ~= self.obj then return end 
	if self.state == 'c' then 
		return 
	end
	if self.state ~= 'd' then
		self.state = 'n'
	end
end
-- function t:mouseWheelUp(tar)
-- 	print("mouseWheelUp",tar)
-- end 
-- function t:mouseWheelDown(tar)
-- 	print("mouseWheelDown",tar)
-- end 
function t:mouseUp(tar)
	if self.state == 'p' and self.btn_class == 1 and self.down == 1 then 
		self.state = 'c'
	elseif self.state == 'c' and self.down == 1 then
		self.state = 'h'
	elseif self.state == 'p' then
		self.state = 'h'
	end 
end
function t:setButtonUnable()
	self.state = 'd'
	self.obj.mouseEnabled = false
end 
function t:setButtonEnable()
	self.state = 'n'
	self.obj.mouseEnabled = true
end 
function t:mouseDown(tar)
	if self.state == 'h' then
		self.state = 'p'
	end
	self.down = 1
end

function t:enable(tar)
	if self.state == 'd' then
		self.state = 'n'
	end
end

function t:disable(tar)
	if self.state ~= 'd' then
		self.state = 'd'
	end
end

function t:set_state()

	self:setImage(self.state)
	self:setTextColor(self.state)
	self:playAudio(self.state)
end
function t:playAudio(state)
	if state == 'h' and self.audio_hover then
		G.Play(self.audio_hover, 1,false,100)
	elseif state == 'p' and self.audio_press then
		G.Play(self.audio_press, 1,false,100)
	end
end 
function t:setTextColor(state)
	if state == 'c' and self.color_toggle then
		self:set_text_color(self.color_toggle)
	elseif state == 'p' and self.color_press then
		self:set_text_color(self.color_press)
	elseif state == 'h' and self.color_hover then
		self:set_text_color(self.color_hover)
	elseif state == 'd' and self.color_disable then
		self:set_text_color(self.color_disable)
	else
		self:set_text_color(self.color_normal)
	end
end
function t:set_img_togEx()
	self:setImage('c')
end 
function t:setImage(state)
	local bg = self.obj.getChildByName("frameList")
	if bg then
		bg.visible = false
	end
	if self.obj.getChildByName("img_ex") then 
		self.obj.getChildByName("img_ex").visible = false
	end 
	if state == 'c' and self.img_toggle then
		self:set_img(self.img_toggle)
		if self.img_togEx then 
			local bg = self.obj.getChildByName("img_ex")
			bg.img = self.img_togEx
			local w,h = G.imageSize(self.img_togEx)
			bg.width = w
			bg.height = h
			bg.visible = true
		end
	elseif state == 'p' and self.img_press then
		self:set_img(self.img_press)
		if self.frameList_press and self.frameList_press ~= "" then 
			self.obj.getChildByName("frameList").visible = true
			self:set_frameList(self.frameList_press)
		end
	elseif state == 'h' and self.img_hover then
		self:set_img(self.img_hover)
	elseif state == 'd' and self.img_disable then
		self:set_img(self.img_disable)
	else
		self:set_img(self.img_normal)
	end
end 
function t:click()
end 
function t:set_frameList(frameList)
	local bg = self.obj.getChildByName("frameList")
	if bg then
		bg.img = frameList
		local w,h = G.imageSize(frameList)
		if self.customsize == nil or self.customsize == false then 
			if w and w > 0 then
				--bg.width = w 
				self.obj.width = w
			end
			if h and h > 0 then
				--bg.height = h
				self.obj.height = h
			end
		end 
	end
end
function t:set_textid()
	local obj = self.obj
	local t = self.obj.getChildByName("text")
	if t then 
		t.textid = self.textid
	end
end
function t:set_text()
	local obj = self.obj
	local t = self.obj.getChildByName("text")
	if t and self.text then 
		t.text = self.text
	end
end 
function t:set_img(img)
	local bg = self.obj.getChildByName("img")
	bg.img = img
	local w,h = G.imageSize(img)
	if self.customsize == nil or self.customsize == false then 
		if w and w > 0 then
			--bg.width = w 
			self.obj.width = w
		end
		if h and h > 0 then
			--bg.height = h
			self.obj.height = h
		end
	end 
end

function t:set_text_color(text_color)
	if text_color then
		self.obj.getChildByName("text").color = text_color
	end
end


-- function t:set_prop(name,value)
-- 	for index,v in pairs(t.prop) do 
-- 		if v.name == name then 
-- 			v = value
-- 			return 
-- 		end 
-- 	end 
-- 	table.insert( t.prop,value )
-- end 
function t:set_img_normal()
	if self.img_normal then 
		self:set_img(self.img_normal)
		
		-- local img = self.obj.getChildByName("img")
		-- if img then 
		-- 	img.width = w
		-- 	img.height = h
		-- end 
		-- local text = self.obj.getChildByName("text")
		-- if text then 
		-- 	text.width = w
		-- 	text.height = h
		-- end 
		
	end
end 
return t
