local GF = require "gfbase"

GF.needcopy_table = {} --存放需要进行deepcopy的表的key
GF.newinst_cache = {}  --动态表cache
GF.extinst = {} --额外的实例（自创武学和角色等）
GF.cache = {}			--静态表
GF.cacheInst = {}	    --静态表对应的动态表数据缓存，主要用于DBTable
GF.new_meta = {
	__index = function(t,k) 
		if k == nil then return nil end
		local dynamic_data = rawget(t,'_dynamic_' .. k) 
		if dynamic_data then 
			return dynamic_data
		end
		if k == 'dbname' then 
			return GF.GetTextOwner(rawget(t,'root') >> 16)
		end
		if rawget(t,'delete_key') == nil or t.delete_key[k] == nil then 
			local new_object = GF.QueryStatic(t.root,t.dbname)
			if new_object and new_object[k] ~= nil then 
				local dbdefname = GF.getDBDefName(t.dbname)
				-- move from gfclient/QueryInit(...)
				-- by zty
				if GF.needcopy_table[dbdefname] == nil then 
					GF.needcopy_table[dbdefname] = {}
					local def = GF.GetDBDef(dbdefname)
					for o_name,li in pairs(def) do 
						if type(li) == 'table' and li.needcopy then 
							GF.needcopy_table[dbdefname][li.name] = true
						end
					end
				end
				if GF.needcopy_table[dbdefname][k] then 
					t[k] = {}
					if new_object[k].name == nil then 
						GF.deepCopyInst(new_object[k],t[k])
					else 
						GF.CopyInst(new_object[k],t[k])
					end
					return t[k]
				else
					return GF.rawgetMemDecodeValue(t, k, new_object[k])
				end 
			else 
				-- 执行内存加密
				return GF.rawgetMemDecodeValue(t, k)
			end 
		end 
	end,
	__newindex = function(t,k,v)
		if v == nil then 
			local dynamic_data = rawget(t,'_dynamic_' .. k) 
			if dynamic_data then 
				rawset(t,'_dynamic_' .. k,nil) 
			end
			if t.delete_key == nil then 
				rawset(t,'delete_key',{}) 
			end 
			t.delete_key[k] = true
			return
		end
		GF.rawsetMemEncodeValue(t, k, v)
	end
}

function GF.ObjectCouldCopy(dbname)
	return false
end
function GF.deepCopyInst(orig, copy,ot)
	local key_table = {}
	ot = ot or {}
	ot[orig] = copy
	setmetatable(copy, getmetatable(orig))
	for k,v in pairs(orig) do
		table.insert(key_table, k)
	end
	table.sort(key_table, function(a, b) return tostring(a) < tostring(b) end)
	for i = 1, #key_table do
		local k = key_table[i]
		local v = orig[k]
		if k == 'class' then
			copy[k] = v
		else
			local v_type = type(v)
			if v_type == 'table' or v_type == 'userdata' then
				if ot[v] then
					rawset(copy,k,ot[v])					
				else
					if v.name and v.name ~= 0 and type(v.name) == 'number' then
						if v.name ~= v.root and GF.ObjectCouldCopy(v.dbname) then 
							copy[k] = GF.CopyInst(v,ot)
						else
							copy[k] = v
						end 
					else 
						rawset(copy,k,{})
						GF.deepCopyInst(v, copy[k], ot)
					end 
					
				end	
			else
				rawset(copy,k,v)
			end
		end
	end
end

function GF.CopyInst(o_inst,ot,o_inst_name)
	local itm = o_inst_name or {}
	local itemname
	if o_inst_name ~= nil then
		itemname  = itm.name
	end 
	GF.deepCopyInst(o_inst,itm,ot)
	if itemname ~= nil then 
		itm.name = itemname  
	end 

	local key = o_inst.root
	local dbname = GF.GetTextOwner(key >> 16)
	local db = GF.DBLoad(dbname)
	if db then
		GF.QueryInit(dbname)
		if not o_inst_name  then 
			local inst_id = GF.NewTextID(dbname)
			-- local num = GF.QuerySize(dbname)
			itm.name = inst_id
			GF.newinst_cache[dbname][inst_id] = itm
		end 
	end 
	return itm
end 

function GF.deepcopy(orig, copy, ot, hide_error)
	-- if hide_error ~= true and orig.dbname == 'o_role' then 
	-- 	error('deepcopy role',orig.name,orig.root,orig.显示名称)
	-- end
	local key_table = {}
	ot = ot or {}
	if ot[orig] then return end
	ot[orig] = 1
	setmetatable(copy,getmetatable(orig))
	for k,v in pairs(orig) do
		table.insert(key_table, k)
	end
	table.sort(key_table, function(a, b)  
		if a == 'type' then return true end 
		if b == 'type' then return false end 
		return tostring(a) < tostring(b) 
	end)
	for i = 1, #key_table do
		local k = key_table[i]
		local v = rawget(orig,k)
		local v_type = type(v)
		if v_type == 'table' or v_type == 'userdata' then
			if ot[v] then
				rawset(copy,k, v)
			else
				rawset(copy,k,{})
				GF.deepcopy(v, copy[k], ot, hide_error)
			end
		else
			rawset(copy,k, v)
		end
	end
end

function GF.GetDBDef(dbname,keyname)
	local ot = GF.DBLoad('o_typedef')
	keyname = keyname or 'define'
	for k,v in pairs(ot[2]) do 
		if v.name == dbname then 
			return v[keyname]
		end 
	end 
end 

function GF.IsTable(tb)
	local tp = type(tb)
	if NEW_DATA_TEST_FZT then 
		if tp == 'userdata' then 
			return GF.not_empty(tb) ~= false
		end
	end
	return tp == 'table' or tp == 'userdata'
end

function GF.QueryIndex(dbname, id)
	if dbname == nil then return end
	local dbsize = GF.QuerySize(dbname)
	if id <= dbsize then 
		local data = GF.QueryStaticByIndex(id,dbname)
		if data then 
			return GF.QueryName(data.name,dbname)
		end
	end 
end

-- 获取某一个表名的所有动态表集合
function GF.DBInst(dbname)
	return GF.newinst_cache[dbname]
end

function GF.addNewInst2Dynamic(o_item,dbname)
	if GF.newinst_cache[dbname] == nil then
		GF.newinst_cache[dbname] = {}
	end 
	if GF.cache[dbname] == nil then
		GF.QueryInit(dbname)
	end 
	setmetatable(o_item,GF.new_meta)
	local inst_id = GF.NewTextID(dbname)
	o_item.name = inst_id
	GF.newinst_cache[dbname][inst_id] = o_item
end 

function GF.addNewInst2Database(o_any_new,dbname)
	if GF.newinst_cache[dbname] == nil then
		GF.newinst_cache[dbname] = {}
	end 
	if GF.cache[dbname] == nil then
		GF.QueryInit(dbname)
	end 
	if GF.extinst[dbname] == nil then 
		GF.extinst[dbname] = {}
	end
	local newid = GF.getNewRoot(dbname)
	o_any_new.root = newid
	o_any_new.name = newid
	table.insert(GF.extinst[dbname],o_any_new)
	table.insert(GF.cacheInst[dbname],o_any_new)
	GF.newinst_cache[dbname][o_any_new.name] = o_any_new
	setmetatable(o_any_new,GF.new_meta)
end 
function GF.IsStaticTable(dbname)
	local dbdefname = GF.getDBDefName(dbname)
	local def = GF.GetDBDef(dbdefname,'static')
	return def
end 

function GF.createNewInst(root)
	local dbname = GF.GetTextOwner(root >> 16)
	local inst_id = GF.NewTextID(dbname)
	local itm = {
		['root'] = root,
		['name'] = inst_id,
		['dbname'] = dbname
	}
	setmetatable(itm,GF.new_meta)
	GF.newinst_cache[dbname][inst_id] = itm
	return itm
end


function GF.QueryName(key,dbname)
	if key == nil or key=='nil' or type(key) ~= 'number' then return end
	if key < 10000 and dbname == nil then return end 
	key = math.floor(key)
	local dbname = dbname or GF.GetTextOwner(key >> 16) or GF.GetTextOwner((key >> 16) - 0x7000)
	if not dbname then
		return nil
	end
	if GF.newinst_cache[dbname] == nil then
		GF.newinst_cache[dbname] = {}
	end 
	
	if GF.newinst_cache[dbname][key] then 
		return GF.newinst_cache[dbname][key]
	else
		local staticData = GF.QueryStatic(key,dbname) 
		if GF.newinst_cache[dbname][key] then 
			return GF.newinst_cache[dbname][key]
		end
		if staticData then 
			if GF.IsStaticTable(dbname) then 
				return staticData
			end 
			local o_any_new = {
				['root'] = staticData.root,
				['name'] = staticData.name,
				['dbname'] = dbname
			}
			if key < 10000 then 
				o_any_new.dbname = dbname
			end 
			setmetatable(o_any_new,GF.new_meta)
			-- GF.newinst[dbname][#GF.newinst[dbname]+1] = o_any_new
			GF.newinst_cache[dbname][o_any_new.name] = o_any_new
			return o_any_new
		end 
    end 
    
    return nil
end

function GF.QueryStatic(key,dbname)
	if key == nil or key=='nil' or type(key) ~= 'number' then return end
	local flag = true
	if dbname ~= nil and key < 10000 then flag = false end
	local o_any_object
	if flag then -- 标记索引表
		o_any_object = GF.QueryStaticByName(key,dbname)
	else 
		o_any_object = GF.QueryStaticByIndex(key,dbname)
	end 
	-- if o_any_object and getmetatable(o_any_object) == nil then 
	-- 	GF.meta(o_any_object)
	-- end 
	return o_any_object
end

-- 查询静态表大小
function GF.QuerySize(dbname)
	local db = GF.DBLoad(dbname)
	return #db[2]
end
function GF.DBTable12(dbname, index,boolean_isstatic)
	if GF.is_editor then
		index = index or 2
		local db = GF.DBLoad(dbname)
		if db then
			GF.QueryInit(dbname)
			return db[index]
		end
	else
		local db = GF.DBLoad(dbname)
		if db then
			GF.QueryInit(dbname)
			return db[2]
		end
	end
end
function GF.DBTable(dbname, index,boolean_isstatic)
	if GF.is_editor then
		index = index or 2
		local db = GF.DBLoad(dbname)
		if db then
			GF.QueryInit(dbname)
			return db[index]
		end
	else
		if GF.cacheInst[dbname] == nil then 
			GF.cacheInst[dbname] = {}
			local db = GF.DBLoad(dbname)
			if db then
				GF.QueryInit(dbname)
			end
		end 
		return GF.cacheInst[dbname]
	end
end

function GF.DBDelete(o_inst)
	if o_inst == nil then return end 
	local ts = os.clock()
	local key = o_inst.root
	local dbname = GF.GetTextOwner(key >> 16)
	local db = GF.DBLoad(dbname)
	if db then
		GF.QueryInit(dbname)
		GF.newinst_cache[dbname][o_inst.name] = nil
	end
end 
function GF.DBAdd(o_inst,dbname)
	if o_inst == nil or o_inst.name == nil then return end
	local key = o_inst.name
	dbname = dbname or GF.GetTextOwner(o_inst.root >> 16)
	local db = GF.DBLoad(dbname)
	if db then
		GF.QueryInit(dbname)
		if  GF.newinst_cache[dbname][key] then 
		else
			GF.newinst_cache[dbname][key]=o_inst
		end
	end
end 
function GF.getDBName(o_inst)
	return GF.GetTextOwner(o_inst.root >> 16)
end 
function GF.getDBDefName(dbname)
	local db = GF.DBLoad(dbname)
	if db then 
		return db[1]
	end 
end 
function GF.CompareInst(o_inst_a,o_inst_b)
	if o_inst_a and o_inst_b then 
		return (o_inst_a.root or o_inst_a.name) == (o_inst_b.root or o_inst_b.name)
	end 
end

local tab_pool = {}
function GF.NewTab()
	local tb = table.remove(tab_pool)
	if tb == nil then tb = {} end
	for k,_ in pairs(tb) do
		tb[k] = nil
	end
	setmetatable(tb,nil)
	return tb
end

function GF.ReleaseTab(tb)
	table.insert(tab_pool, tb)
end
function GF.getNewRoot(dbname)
	local dbname_map = {
		['o_kungfu'] = 0x1006ffff,
		['o_role'] = 0x1001ffff,
		['o_item'] = 0x1003ffff,
	}
	local startid = dbname_map[dbname]
	while true do 
		if GF.cache[dbname][startid] == nil and GF.newinst_cache[dbname][startid] == nil then 
			return startid
		end 
		startid = startid - 1
	end 
	
end 
function GF.hasID(dbname,id)
	if GF.newinst_cache[dbname] and GF.newinst_cache[dbname][id] then return true end 
end 
local luaid
function GF.NewTextID(dbname)
	local prefixID = 0
	local bigPrefix = 0
	local newID = 0
	if GF.newTextIDIndex == nil then 
		GF.newTextIDIndex = {}
		GF.newTextIDIndex_max = {}
	end
	if luaid == nil then
		luaid = {}
		local luaid_t = require 'servershare/luaid'
		for k,v in pairs(luaid_t) do
			luaid[v] = k
		end
	end
	if GF.newTextIDIndex[dbname] == nil then
		if luaid[dbname] then 
			prefixID = luaid[dbname] + 0x7000 --避免新产生的ID与静态数据表ID重复，动态表ID以8000开头，静态表以1000开头
			prefixID = prefixID << 16
			GF.newTextIDIndex[dbname] = prefixID | 1
			GF.newTextIDIndex_max[dbname] = prefixID | 0xfffd
		end
	end 
	prefixID = GF.newTextIDIndex[dbname]
	bigPrefix = GF.newTextIDIndex_max[dbname]
	while prefixID ~= 0 do
		for i = prefixID, bigPrefix do
			if not GF.hasID(dbname,i) then
				newID = i
				GF.newTextIDIndex[dbname] = newID
				return newID
			end
		end
		if prefixID > bigPrefix then 
			prefixID = ((luaid[dbname] + 0x7000) << 16) | 1
		else
			break
		end 
	end
	return newID
end

function GF.number2string(number_value)
    if number_value == nil then return '' end 
    if number_value > 0 then 
        return '+' .. tostring(number_value) 
    elseif number_value < 0 then 
        return tostring(number_value) 
    else 
        return '0'
    end 
end 

function GF.clearDynamic()
	GF.newinst_cache = {}
	GF.cache = {}
	GF.cacheInst = {}
end 


function GF.QueryStaticByName(key,dbname)
	if key == nil or key=='nil' or type(key) ~= 'number' then return end
	local dbname = dbname or GF.GetTextOwner(key >> 16)
	local db = GF.DBLoad(dbname)
	if db then
		GF.QueryInit(dbname)
		return GF.cache[dbname][key]
	end
end
function GF.QueryStaticByIndex(index,dbname)
	local db = GF.DBLoad(dbname)
	if db then
		GF.QueryInit(dbname)
		return db[2][index]
	end
end
function GF.DBLoad(dbname)
	if dbname then
		local db = require(dbname) -- luadb.dbload(dbname, buff) --require(dbname)
		if not GF.IsTable(db) then return nil end
		return db
	end
end

-- 将静态数据读取到内存并设置metatable和表需要拷贝的属性，提升读取速度
function GF.QueryInit(dbname)
	if GF.cache[dbname] == nil then
		GF.cache[dbname] = {}
		GF.cacheInst[dbname] = {}
	else
		return
	end
	local cache = GF.cache[dbname]
	local tcache = GF.cacheInst[dbname]
	local db = GF.DBLoad(dbname)
	for k,v in ipairs(db[2]) do
		if v.root == nil then
			v.root = v.name
		end
		cache[v.name] = v
		tcache[#tcache+1] = GF.QueryName(v.name,dbname)
	end
	--if GF.is_editor or GF.IsStaticTable(dbname) then
		for i = 1, #db[2] do
			if getmetatable(db[2][i]) == nil then
				GF.meta(db[2][i])
			end
		end
	--end
end

-- FIXME: 临时处理, 换用新数据框架后删除
function GF.DeleteDataAttr(data, attr)
	if GF.IsTable(data) and attr ~= nil then 
		data.attr = nil
		if data.delete_key == nil then 
			data.delete_key = {}
		end
		data.delete_key[attr] = true
	end
end
