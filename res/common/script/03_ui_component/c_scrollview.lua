--[[3102
,
]]
local G = require 'gf'

local t = G.com()

t.prop = 
{
	{name = 'Horizontal', type = 'boolean', ctrl = 'boolean'},
	{name = 'Vertical', type = 'boolean', ctrl = 'boolean'},
	{name = 'Sensitivity', type = 'int', ctrl = 'dragint',ctrl_arg = { min=0,max = 100}},
	{name = 'type',	type = 'int', ctrl = 'combo_idx', ctrl_arg = { '普通版',  '优化版'} },
	{name = 'autoMove', type = 'boolean', ctrl = 'boolean'},
	{name = 'hideSlider', type = 'boolean', ctrl = 'boolean'},
}

function t:init()
	self.obj.mouseEnabled = true
	self.state = 'normal'
	self.mask = self.obj.getChildByName("mask")
	self.content = self.obj.getChildByName("content")
	self.slider = self.obj.getChildByName('slider')
	self.slider_bg = self.slider.getChildByName('背景')
	self.slider_bt = self.slider.getChildByName('按钮')
	if self.type == 1 then
		self._dataNum = 20
		self.fun = function(ui_node,index)
		end 
		self.disvisiblefun = function(ui_node,index)
			ui_node.visible = false
		end 
	end 
	self.needAutoMove = true
	self.visibleChildCount = 0 
	self:getAllChildren()
end
function t:updateSlider()
	local contentHeight = self.content.real_height()
	local maskHeight = self.mask.real_height()
	if self.hideSlider then 
		self.slider.visible = false
		return 
	end 
	if self.type ~= 1 then
		if contentHeight <= maskHeight then 
			self.slider.visible = false
		else 
			self.slider.visible = true
			self.slider_bt.y = -self.content.y / contentHeight * maskHeight
			self.slider_bt.height = maskHeight/contentHeight * maskHeight
		end 
	elseif self.layer then 
		if self.visibleChildCount >= self._dataNum and self.content.y == 0 then  -- 判断是否超过一屏幕
			self.slider.visible = false
		else
			self.slider.visible = true
			local minindex = math.huge
			local maxindex = 0
			for i=1,#self.allChild do
				if self.allChild[2] then 
					if minindex > self.allChild[i]._index then 
						minindex = self.allChild[i]._index
					end 
					if maxindex < self.allChild[i]._index then 
						maxindex = self.allChild[i]._index
					end 
				end
			end 
			self.minindex = minindex
			local reallymaxindex = 0 
			self.reallymaxindex = maxindex -- 记录一下原有的最大下标，有待优化
			self.maxindex = maxindex - minindex + 1
			if self.space then 
				local sumheigth = math.ceil(self._dataNum/self.layer) * self.allChild[1][1].real_height() + (math.ceil(self._dataNum/self.layer) - 1) * self.space
				
				local beforeheight = (self.minindex-1)/self.layer * self.allChild[1][1].real_height() + self.content.y
				if ((self.minindex-1)/self.layer) > 1 then 
					beforeheight = beforeheight + ((self.minindex-1)/self.layer)* self.space
				end 

				-- 当滚动到最底部时，总高度计算需要加上 content.y
				if(self.content.y > 0 and self._dataNum <= self.reallymaxindex - self.layer) then
					sumheigth = sumheigth + self.content.y 
							  			  + math.floor((self.reallymaxindex - self._dataNum)/self.layer - 1) * (self.allChild[1][1].real_height() + self.space)
					-- beforeheight = beforeheight + math.ceil((self.reallymaxindex - self._dataNum)/self.layer - 1) * (self.allChild[1][1].real_height() + self.space)
				end

				self.maxindex = self.maxindex - self.layer
				local showheight = self.maxindex/self.layer*self.allChild[1][1].real_height() + (self.maxindex/self.layer-1)*self.space
				
				self.slider_bt.y = -(beforeheight) / sumheigth * maskHeight
				self.slider_bt.height = maskHeight / sumheigth * maskHeight
			end 
		end 
	end 
	if self.Vertical ~= true then 
		self.slider.visible = false
	end 
end 
function t:setDataFun(fun)
	self.fun = fun
end 
function t:setDisvisibleFun(fun)
	self.disvisiblefun = fun
end 
function t:setDataNum(num)
	self._dataNum = num
end  
function t:initUI()
	self:getAllChildren()
	for i=#self.allChild,self._dataNum+1,-1 do
		self.disvisiblefun(self.allChild[i][1],i)
		self.allChild[i][2] = false
		--table.remove( self.allChild,i)
	end 
	for index=1,self._dataNum do 
		if index <= #self.allChild then 
			self.fun(self.allChild[index][1],index)
			self.allChild[index][1].visible = true	
			self.allChild[index][2] = true		
		end 
	end 
	self.content.y= 0
	self:preProcessSuper('y')
	self:updateSlider()
end 
function t:updateUI()
	
	for index=1,#self.allChild do 
		
		if self.allChild[index]._index <= self._dataNum then 
			self.fun(self.allChild[index][1],self.allChild[index]._index)
			self.allChild[index][1].visible = true
			self.allChild[index][2] = true	
		else
			self.disvisiblefun(self.allChild[index][1],self.allChild[index]._index)
			self.allChild[index][2] = false
		end 
	end 
end 
function t:preProcessSuper(xy)
	local sortfunc = function(a,b)
		if xy == 'y' then 
			if a[1].y > b[1].y then return true
			elseif a[1].y == b[1].y then return a._index < b._index 
			else return false end 
		elseif xy == 'x' then 
			if a[1].x < b[1].x then return true
			elseif a[1].x == b[1].x then return a._index < b._index 
			else return false end 
		end 
	end 
	table.sort(self.allChild,sortfunc)
	local layer_child = {}
	local layer_index = 1
	local lastIndex = 1
	local firstIndex = self.allChild[1]._index
	local firstChild = self.allChild[1]
	for index,child in ipairs(self.allChild) do
		--if child[2] or child[1][xy] == firstChild[1][xy] then 
			if child[1][xy] == firstChild[1][xy] then 
				if layer_child[layer_index] == nil then 
					layer_child[layer_index] = {}
				end
				table.insert(layer_child[layer_index],child)
			else 
				layer_index = layer_index + 1
				firstChild = child
				if layer_child[layer_index] == nil then 
					layer_child[layer_index] = {}
				end 
				table.insert(layer_child[layer_index],child)
			end 
			lastIndex = child._index
		--end 
	end 
	-- 计算行间距
	local space = 0
	if #layer_child >= 2 then 
		if xy == 'y' then 
			space = layer_child[1][1][1].y - layer_child[2][1][1].y - layer_child[1][1][1].real_height()
		elseif xy == 'x' then 
			space = layer_child[2][1][1].x - layer_child[1][1][1].x - layer_child[1][1][1].real_width()
		end 
	end 
	self.layer_child = layer_child
	self.firstIndex = firstIndex
	self.lastIndex = lastIndex
	self.space = space
	self.layer = 1
	if #layer_child >= 1 then 
		self.layer = #layer_child[1]
	end 
	self.visibleChildCount = #self.allChild - self.layer -- 可见区域内child的个数
	return layer_child,firstIndex,lastIndex,space
end 
function t:super_start2tail(layer_child,lastIndex)
	-- 开始移到最后
	for i=1,#layer_child[1] do 
		local fc = layer_child[1][i]
		fc._index = lastIndex + i
		self.content.addChild(fc[1])
		self.fun(fc[1],fc._index)
		if fc._index > self._dataNum then 
			--fc[1].visible = false
			fc[2] = false
			self.disvisiblefun(fc[1],fc._index)
		end 
	end 
end 
function t:super_tail2start(layer_child,firstIndex)
	-- 最后移到开始
	for i=1,#layer_child[1] do 
		local fc = layer_child[#layer_child][i]
		fc._index = firstIndex - (#layer_child[1]-i+1)
		self.content.addChildAt(layer_child[#layer_child][i][1],i-1)
		self.fun(fc[1],fc._index)
		fc[1].visible = true
		fc[2] = true
	end 
end 
-- 优化版使用
function t:moveChlidPosition()
	if self.type and self.type == 1 then 
		if self.Vertical then 
			local layer_child,firstIndex,lastIndex,space = self:preProcessSuper('y')
			if #layer_child < 1 then return end 
			local childInfo = layer_child[1][1]
			--竖：开始移到最后
			if lastIndex < self._dataNum and self.content.y - childInfo[1].real_height() - space >= 0 then 
				self:super_start2tail(layer_child,lastIndex)
				self.content.y = self.content.y - self.allChild[1][1].real_height()- space
			end
			
			--竖：最后移到开始
			if firstIndex > 1 and self.content.y < 0 then 
				self:super_tail2start(layer_child,firstIndex)
				self.content.y = self.content.y + layer_child[#layer_child][1][1].real_height() + space
			end
		end 

		if self.Horizontal then
			-- 水平方向预处理
			local layer_child,firstIndex,lastIndex,space = self:preProcessSuper('x')
			if #layer_child < 1 then return end 
			
			local childInfo = layer_child[1][1]

			--横：开始移到最后
			if lastIndex < self._dataNum and self.content.x < -(space + childInfo[1].real_width()) then 
				self:super_start2tail(layer_child,lastIndex)
				self.content.x = self.content.x + self.allChild[1][1].real_width() + space
			end
			
			--横：最后移到开始
			if firstIndex > 1 and self.content.x > 0 then 
				self:super_tail2start(layer_child,firstIndex)
				self.content.x = self.content.x - layer_child[#layer_child][1][1].real_width() - space
			end
		end 
	end 
end 
function t:getContentRealHeight()
	local reallycontentHeight = self.content.real_height()
	if self.type and self.type == 1 and self.layer_child ~= nil then 
		local int_num = math.ceil(self.lastIndex / self.layer)
		if #self.layer_child > 1 then 
			reallycontentHeight = int_num * self.layer_child[1][1][1].real_height() + (int_num - 1) * self.space
		else
			reallycontentHeight = 0
		end 
		
	end 
	return reallycontentHeight
end 
function t:setChildPosition(deltaX,deltaY)	
	
	if #self.allChild == 0 then return end 
	if self.type and self.type == 1 then 
		if self.allChild[1]._index == 1 and self.content.y + deltaY < 0 then 
	
			deltaY = -self.content.y
		end 
	else 
		if self.content.y + deltaY < 0 then 
			deltaY = -self.content.y
		end 
	end 
	
	-- 到最底，防止继续往上拖动
	local reallycontentHeight = self:getContentRealHeight()
	if reallycontentHeight < self.mask.real_height()  then 
		deltaY = 0
	elseif self.content.real_height() - self.content.y - deltaY < self.mask.real_height() then 
		deltaY = (self.content.real_height() - self.content.y) - self.mask.real_height() 
	end 
	
	-- 到最左，防止继续往右拖动
	if self.type and self.type == 1 then 
		if self.allChild[1]._index == 1 and self.content.x + deltaX > 0 then 
			deltaX =  -self.content.x
		end 
	else 
		if self.content.x + deltaX > 0 then 
			deltaX =  -self.content.x
		end 
	end 

	-- 到最右，防止继续往左拖动
	if self.content.x + self.content.real_width() + deltaX <= self.mask.x + self.mask.real_width() then 
		deltaX = self.mask.x + self.mask.real_width() -(self.content.x + self.content.real_width() )
	end 

	-- 进行水平和垂直移动
	if self.Vertical then 
		self.content.y = self.content.y + deltaY
	end 
	if self.Horizontal then
		self.content.x = self.content.x + deltaX
	end 
	--end 

	-- 循环使用控件
	self:moveChlidPosition()
	self:isCanAutoMove()
end 
function t:needSetPosition()
	if self.type==1 then 
		if self._dataNum > self.visibleChildCount or self.content.y > 0 then 
			return true
		end 
	else 
		if (self.Vertical and self.content.real_height() > self.mask.real_height() ) or self.content.y > 0 then 
			return true
		end 
		if self.Horizontal and self.content.real_width() > self.mask.real_width() then 
			return true
		end 
	end
	return false
end 
function t:mouseWheelUp(tar)
	if self:needSetPosition() then 
		self:setChildPosition(0,-self.Sensitivity)
	end 
end 
function t:mouseWheelDown(tar)
	if self:needSetPosition() then 
		self:setChildPosition(0,self.Sensitivity)
	end 
end 
function t:getAllChildren()
	self.allChild = {}
	local index= 1
	for i=0,self.content.childCount - 1  do
		local child = self.content.getChildAt(i)
		--if child and child.visible then 
			table.insert( self.allChild,{child,true,['_index']=index} )
			index = index + 1
		--end 
	end 
	return self.allChild
end 
function t:boundUpdated()
	if self.type ~= 1 then 
		self:getAllChildren()
	end 
	
	
	self:updateSlider()
	
	if self.autoMove == true and self.needAutoMove then 
		if self.Vertical then 
			self.content.y = self.content.real_height() - self.mask.real_height()
			if self.content.y < 0 then 
				self.content.y = 0
			end 
		end 
	end 
	
end 
function t:update()
	if G.MouseState() == 0 then 
		self.state = 'down'		
	else 
		self.state = 'up'
		self.slider_y = nil
	end 
	--self:updateSelf()	
	
end 
function t:mouseDown(tar)
	if self.ignore then return end
	-- if self:needSetPosition() then G.SetFocus(self.obj)	 end
	if tar == self.slider_bt then 
		local x,y = G.MousePos()
		self.slider_y = y
	end 
	self.state = 'down'
end 
function t:mouseUp(tar)
	G.SetFocus()
	self.slider_y = nil
	self.state = 'up'
end 
function t:isCanAutoMove()
	if math.abs(self.content.real_height() - (self.content.y + self.mask.real_height())) < 1  then 
		self.needAutoMove = true
	else 
		self.needAutoMove = false
	end 
end 
function t:mouseMove(tar)
	if self.ignore then return end
	if not self:needSetPosition() then return end
		
	local x,y = G.MouseDelta()	
	if self.slider_y then 
		local movedis = y/self.slider_bt.real_height()*self.mask.real_height()
		if self.type == 1 then 
			
			--self.slider_y = y
			local int_flag = 1
			if movedis < 0 then int_flag = -1 end
			local h = self.layer_child[1][1][1].real_height()/2
			movedis = math.abs(movedis)
			if movedis > h then 
				local int_count = movedis/h
				int_count = math.floor(int_count)
				for int_i=1, int_count do 
					self:setChildPosition(0,int_flag * h)
				end 
				self:setChildPosition(0,int_flag*(movedis - int_count * h))
			else
				self:setChildPosition(0,int_flag * movedis)
			end 
		else 
			self:setChildPosition(0,movedis)
		end 
		
	elseif self.state == 'down' then  
		-- if self.state == 'down' then 
		local dx,dy = G.MouseDownDelta()
		if dx * dx + dy * dy < 100 then 
			return 
		end 
		G.SetFocus(self.obj)	
		self:setChildPosition(-x,-y)
	-- end 
	end 
	-- TODO: 弹性效果
	-- if self.state == 'down' then 
	-- 	local x,y = G.MouseDelta()
	-- 	self:setChildPosition(-x,-y)
	-- end 
end 
function t:setIgnored(boolean_ig)
	self.ignore = boolean_ig
	if boolean_ig == false then 
		self:mouseUp()
	end
end
return t
