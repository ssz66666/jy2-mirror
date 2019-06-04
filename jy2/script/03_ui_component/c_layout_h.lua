--[[3106
,
]]
local G = require 'gf'

local t = G.com()

t.prop = 
{
	-- {name = 'Sensitivity', type = 'int', ctrl = 'dragint',ctrl_arg = { min=0,max = 100}},
	{name = 'alignment_h',	type = 'int', ctrl = 'combo_idx', ctrl_arg = { '左','中','右'} },
	{name = 'alignment_v',	type = 'int', ctrl = 'combo_idx', ctrl_arg = { '上','中','下'} },
	{name = 'RowSpace', type = 'int', ctrl = 'dragint'},
	{name = 'StartX', type = 'int', ctrl = 'dragint'},
	{name = 'changePivot', type = 'int', ctrl = 'boolean'},
	{name = 'changeAnchor', type = 'int', ctrl = 'boolean'},
}


function t:boundUpdated()
	self.changePivot = self.changePivot or false 
	self.changeAnchor = self.changeAnchor or false 
	-- 过滤所有不显示的child
	local allChild = G.NewTab()
	local widthSize = 0
	for i=0,self.obj.childCount-1 do
		local child = self.obj.getChildAt(i)
		if child and child.visible then
			if self.changePivot == false and (child.pivotX ~= 0 or child.pivotY ~= 1) then 
				child.pivotX = 0
				child.pivotY = 1
			end 
			if self.changeAnchor == false and child.anchor ~= 0x64640000 then 
				child.anchor = 0x64640000
			end 
			table.insert( allChild,child )
			widthSize = widthSize + G.GetObjRealWidth(child)
		end 
	end  
	if #allChild == 0 then 
		G.ReleaseTab(allChild)
		return 
	end 

	-- 以第一个child的位置为起始位置
	self.RowSpace = self.RowSpace or 10
	self.alignment_h = self.alignment_h or 0
	self.alignment_v = self.alignment_v or 0
	self.StartX = self.StartX or 0
	local startX = 0
	local startY = 0

	
	-- 对齐方式，以哪一个为标准
	if self.alignment_h == 0 then -- 左对齐
		startX = 0
	elseif self.alignment_h == 1 then -- 中对齐
		startX = G.GetObjRealWidth(self.obj) / 2 - (widthSize+self.RowSpace*(#allChild-1)) / 2 
	elseif self.alignment_h == 2 then -- 右对齐
		startX = G.GetObjRealWidth(self.obj) - (widthSize+self.RowSpace*(#allChild-1))
	end 
	startX = startX + self.StartX
	for i=1,#allChild do 
		local child = allChild[i]
		if child.x ~= startX then 
			child.x = startX
		end 
		if self.alignment_v == 0 then -- 上对齐
			startY = 0
		elseif self.alignment_v == 1 then -- 中对齐
			startY = -G.GetObjRealHeight(self.obj) / 2 + G.GetObjRealHeight(child)/2
		elseif self.alignment_v == 2 then -- 下对齐
			startY = -G.GetObjRealHeight(self.obj) + G.GetObjRealHeight(child)
		end 
		if child.y ~= startY then 
			child.y = startY
		end 
		startX = startX + G.GetObjRealWidth(child) + self.RowSpace
	end 
	G.ReleaseTab(allChild)
end 
return t