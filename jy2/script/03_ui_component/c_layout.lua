--[[3105
,
]]
local G = require 'gf'

local t = G.com()

t.prop = 
{
	-- {name = 'Sensitivity', type = 'int', ctrl = 'dragint',ctrl_arg = { min=0,max = 100}},
	{name = 'direction',	type = 'int', ctrl = 'combo_idx', ctrl_arg = { '竖向','横向'} },
	{name = 'constraint',	type = 'int', ctrl = 'combo_idx', ctrl_arg = { '固定行数','固定列数'} },
	{name = 'alignment_h',	type = 'int', ctrl = 'combo_idx', ctrl_arg = { '左','中','右'} },
	{name = 'alignment_v',	type = 'int', ctrl = 'combo_idx', ctrl_arg = { '上','中','下'} },
	{name = 'Count', type = 'int'},
	{name = 'RowSpace', type = 'int', ctrl = 'dragint'},
	{name = 'ColSpace', type = 'int', ctrl = 'dragint'},
	{name = 'StartSpaceX', type = 'int', ctrl = 'dragint'},
	{name = 'StartSpaceY', type = 'int', ctrl = 'dragint'},
	{name = 'containVisible', type = 'boolean', ctrl = 'boolean'},
}

function t:boundUpdated()
	self.containVisible = self.containVisible or false
	-- 过滤所有不显示的child
	local allChild = G.NewTab()
	for i=0,self.obj.childCount-1 do
		local child = self.obj.getChildAt(i)
		if child and (self.containVisible == true or child.visible ~= false) then
			if child.pivotX ~= 0 then 
				child.pivotX = 0
			end 
			if child.pivotY ~= 1 then 
				child.pivotY = 1
			end 
			if child.anchor ~= 0x64640000 then 
				child.anchor = 0x64640000
			end 
			table.insert( allChild,child )
		end 
	end  
	if #allChild == 0 then 
		G.ReleaseTab(allChild)
		return 
	end 

	-- 以第一个child的位置为起始位置
	self.direction =self.direction or 0
	self.constraint = self.constraint or 0
	self.Count = self.Count or 1
	self.RowSpace = self.RowSpace or 10
	self.ColSpace =self.ColSpace or 10
	self.alignment_h = self.alignment_h or 0
	self.alignment_v = self.alignment_v or 0
	self.StartSpaceX = self.StartSpaceX or 0
	self.StartSpaceY = self.StartSpaceY or 0
	local startX = 0
	local startY = 0
	local nextX = 0
	local nextY = 0
	local cw = allChild[1].width
	local ch = allChild[1].height
	local widthCount = self.Count
	local heightCount = self.Count
	local ChangeDirCount = self.Count
	if self.constraint == 0 then
		widthCount = math.ceil(#allChild / self.Count)
	else 
		heightCount = math.ceil(#allChild / self.Count)
	end 

	if self.direction ~= self.constraint then 
		ChangeDirCount = math.ceil(#allChild / self.Count)
	end 
	-- 对齐方式，以哪一个为标准
	if self.alignment_h == 0 then -- 左对齐
		startX = 0
	elseif self.alignment_h == 1 then -- 中对齐
		startX = self.obj.width / 2 - (cw * widthCount+self.RowSpace*(widthCount-1)) / 2 
	elseif self.alignment_h == 2 then -- 右对齐
		startX = self.obj.width - (cw * widthCount+self.RowSpace*(widthCount-1))
	end 
	if self.alignment_v == 0 then -- 上对齐
		startY = 0
	elseif self.alignment_v == 1 then -- 中对齐
		startY = -self.obj.height / 2 + (ch * heightCount+self.ColSpace*(heightCount-1)) / 2 
	elseif self.alignment_v == 2 then -- 下对齐
		startY = -self.obj.height + (ch * heightCount+self.ColSpace*(heightCount-1))
	end 
	startX = startX + self.StartSpaceX
	startY = startY - self.StartSpaceY
	nextX = startX
	nextY = startY

	local i=1
	for index=1,#allChild do 
		if (i-1)%ChangeDirCount == 0 then 
			if self.direction ==  0 then -- 竖向
				nextX = startX + (i-1)/ChangeDirCount*cw
				if i>0 then 
					nextX = nextX + (i-1)/ChangeDirCount*self.RowSpace
				end 
				nextY = startY
			else -- 水平
				nextX = startX
				nextY = startY - (i-1)/ChangeDirCount*ch
				if i>1 then 
					nextY = nextY - (i-1)/ChangeDirCount*self.ColSpace
				end 
			end 
		end 
		local ii = 1
		for index2 = 1,ChangeDirCount do 
			local child = allChild[i]
			if child ~= nil and (self.containVisible == true or child.visible ~= false) then 
				if child.x ~= nextX then
					child.x = nextX
				end 
				if child.y ~= nextY then 
					child.y = nextY
				end 
				if self.direction ==  0 then -- 竖向
					--child.x = nextX
					nextY = nextY - child.height - self.ColSpace
				else
					nextX = nextX + child.width + self.RowSpace
					--child.y = nextY
				end 
				
				ii = ii + 1
			end 
			i = i+1
		end 
	end 
	G.ReleaseTab(allChild)
end 
return t