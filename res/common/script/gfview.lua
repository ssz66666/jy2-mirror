
local GF = require "gfbase"
local c = require "gcore.c"

local ui_data = {}

function GF.clear_ui()
	local st = c.Stage()
	st.removeAllChildren()
	GF.addUI('v_common')
end

function GF.save_ui()
	local st = c.Stage()
	for k = 1,st.childCount do
		local ui = st.getChildAt(k -1)
		local u_data = ui_data[ui.name]
		if u_data then
			if ui.visible == true then
				u_data.__visible = true
				u_data.__index = k
				--table.insert(ud, u_data)
			else
				u_data.__visible = false
			end
		end
	end
	ui_data.__text = {}
	c.GetTextRecorded(ui_data.__text)
	return ui_data
end

function GF.load_ui(ud)
	local gtext = ud.__text
	local ui_list = {}
	if gtext then
		for k,v in pairs(gtext) do
			c.SetText(k,v)
		end
		ud.__text = nil
	end
	local st = c.Stage()
	st.removeAllChildren()

	ui_data = ud
	-- for k, v in ipairs(ud) do
	-- 	if v.__name == 'v_common' then
	-- 		ui_data['v_common'] = v
	-- 	end
	-- end
	GF.addUI('v_common').sendMsg("setData")
	for k,v in pairs(ud) do
		if v.__visible == true then
			table.insert(ui_list, {name = k, index = v.__index})

		end
	end
	table.sort(ui_list, function(a, b) return a.index < b.index end)
	for i = 1, #ui_list do
		if ui_list[i].name ~= 'v_common' then
			local ui_obj = GF.addUI(ui_list[i].name)
			ui_obj.sendMsg("setData")
		end
	end
	GF.addUI('v_common').sendMsg("setData")
end

function GF.QueryUIData(ui, sub)
	ui_data[ui] = ui_data[ui] or {}
	if sub then
		ui_data[ui][sub] = ui_data[ui][sub] or {}
		return ui_data[ui][sub]
	end
	return ui_data[ui]
end

function GF.RemoveUIData(ui, sub)
	if sub then
		ui_data[ui][sub] = nil
		return ui_data[ui][sub]
	else
		ui_data[ui] = nil
		return ui_data[ui]
	end
end

function GF.ClearUIData()
	ui_data = {}
	return ui_data
end

function GF.addUI(name)
	if GF.getUI(name) then return GF.getUI(name) end
	local root = c.loadUI(name)
	c.Stage().addChild(root)
	if not GF.is_editor then 
		GF.trig_event('UI_added',name)
	end
	return root
end

function GF.GetAllUI()
	local root_ui = c.Stage()
	local ui_list = {}
	for i = 1, root_ui.childCount do 
		local ui = root_ui.getChildAt(i - 1)
		table.insert(ui_list, ui)
	end
	return ui_list
end

function GF.changeUI(name)
	c.Stage().removeAllChildren()
	return GF.addUI(name)
end

function GF.removeUI(obj)
	local name
	if not obj then
		return
	end
	if type(obj) == 'string' then
		name = obj
		obj = c.Stage().getChildByName(obj)
	else
		name = obj.name
	end
	c.Stage().removeChild(obj)
	GF.RemoveUIData(name)
	if not GF.is_editor then 
		GF.trig_event('UI_removed', name)
	end
	if GF.DestroyUI then 
		GF.DestroyUI(obj)
	end
end

function GF.getUI(name)
	return  c.Stage().getChildByName(name)
end

function GF.getUIChildren(obj)
	local children = {}
	if obj ~= nil then
		for i=0, obj.childCount - 1  do
			children[i + 1] = obj.getChildAt(i)
		end
	end
	return children
end


function GF.FindNode(...)
	return c.FindNode(table.concat({...}, '|'), '|')
end

function GF.AddNode(resID, parent, idx, x, y, w, h, rot,scale)
	if parent == nil then
		parent = c.Stage()
	end
	local tp = resID & 0xf000000
	local node
	local iw,ih = c.imageSize(resID)
	if tp == 0x06000000 then
		node = c.Quad()
	elseif tp == 0x05000000 then
		node = c.SpineQuad()
		iw = 100
		ih = 100

		node.img = resID
		node.animData =  (resID & 0x0fffff00) | 0x30000011
	elseif tp == 0x04000000 then
		node = c.ParticleSystem()
		iw = 100
		ih = 100
		-- node.startSize = iw
		node.startWidth = iw
		node.startHeight = ih
		node.startAlpha = 255
		node.totalP = 100
		node.speed = 100
	elseif tp == 0x03000000 then
		node = c.Quad()
	elseif tp == 0x02000000 then
		node = c.TextQuad()
	end
	node.img = resID
	node.x = x
	node.y = y
	if w > 0 then
		node.width = w
	else
		node.width = iw
	end
	if h > 0 then
		node.height = h
	else
		node.height = ih
	end
	node.rotation = rot
	node.scaleX = scale
	node.scaleY = scale
	parent.addChildAt(node,idx)

	GF.AddManageNode(node)
	return node
end

function GF.RemoveNode(node)
	node.removeFromParent()
end

--------------------------------------
function GF.loadGrid9(g9)
	for k = 2, #g9 do
		local g = g9[k]
		for j,u in ipairs(g) do
			c.setImageGrid(u.name, u[1],u[2],u[3],u[4])
		end
	end
end
function GF.loadFont(ft)
	local ft = ft[2]
	c.SetFontName(-1,'')
	for j,u in ipairs(ft) do
		c.SetFontName(j - 1,u.fontname, u.ttf, u.sdf)
	end
end

function GF.loadFontStyle(ft)
	local ft = ft[2]
	local lst = {}
	local max = 0
	local idx
	for j,u in ipairs(ft) do
		idx = u.name & 0xff
		lst[idx] = u
		if idx > max then max = idx end
	end
	for k = 1, max do
		local u = lst[k]
		if u then
			c.addFntStyle(u.color,u.color2 or u.color, u.shadowColor or 0,0,u.outlineThick)
		else
			c.addFntStyle(0,0,0,0,0)
		end
	end
end
--------------------------------------
function GF.creataTrail(image,height,lifetime,fadetime)
	local trail = GF.Trail()
  trail.img = image
  trail.lifeTime = lifetime
  trail.fadeTime = fadetime
  trail.width = 1
  trail.height = height
  trail.name = 'trail'
	return trail
end

function GF.createShape(x,y,ver,tex)
	local tc = c.Shape()
	tc.name = 'test'
	tc.x = x
	tc.y = y
	tc.anchor = 0
	tc.width = 140
	tc.height = 140
	tc.img = tex
	local vertex = {
		ver[1][1],ver[1][2],
		ver[2][1],ver[2][2],
		ver[3][1],ver[3][2],
		ver[1][1],ver[1][2],
		ver[3][1],ver[3][2],
		ver[4][1],ver[4][2],
	}
	local uv = {
		0,0,
		1,0,
		1,1,
		0,0,
		1,1,
		0,1
	}
	tc.SetVertexBuf(6,vertex, uv,0xffffffff)
	return tc
end


-----------------------------------
function GF.GetObjRealWidth(ui_obj)
    return ui_obj.real_width() * ui_obj.scaleX
end
function GF.GetObjRealHeight(ui_obj)
    return ui_obj.real_height() * ui_obj.scaleY
end
function GF.SetObjAttr(obj,attr,value)
	if obj[attr] ~= value then
		obj[attr] = value
	end
end

function GF.TranslateSpineanim(spineanim_name)
	local spinename = GF.ToHexUINT(string.sub(spineanim_name,3,10))
	local spineanimname = GF.ToHexUINT(string.sub(spineanim_name,11,18))
    local spine_name = (spinename << 32) | spineanimname
	local anim_name = string.sub(spineanim_name,19)
	return spine_name,anim_name
end
