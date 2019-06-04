
local GF = require('gfbase')
local es = require 'gevent'

function GF.save_ofile(o_list)
	if type(o_list) == 'string' then
		-- clear_table(GF.newinst_cache[o_list],{},'关系链')
		return GF.newinst_cache[o_list]
	end
	-- clear_table(GF.newinst_cache,{},'关系链')
	return {GF.newinst_cache,GF.extinst}
end
function GF.load_ofile(obj)
	GF.newinst_cache = obj[1]
	GF.extinst = obj[2]
	for o_name,v in pairs(obj[1]) do
		local db = require(o_name)
		GF.QueryInit(o_name)
		if GF.extinst[o_name] then
			for i=1,#GF.extinst[o_name] do
				table.insert(GF.cacheInst[o_name],GF.extinst[o_name][i])
			end
		end
	end
end
GF.cur_script_id = 0x103c0001
function GF.GetSavePath(file)
	local path
	GF.MakeDirIfNotExist("save/")
	if type(GF.get_isconnect) == 'function' and GF.get_isconnect() and GF.player_id then
		GF.MakeDirIfNotExist("save/netplay")
		GF.MakeDirIfNotExist('save/netplay/' .. tostring(GF.player_id))
		GF.MakeDirIfNotExist("save/netplay/" .. tostring(GF.player_id) .. '/' .. tostring(GF.cur_script_id))
		path = GF.WritePath(string.format("save/netplay/%s/%s/%s", tostring(GF.player_id),tostring(GF.cur_script_id), tostring(file)))
	else
		GF.MakeDirIfNotExist("save/single")
		GF.MakeDirIfNotExist("save/single/" .. tostring(GF.cur_script_id))
		path = GF.WritePath(string.format("save/single/%s/%s", tostring(GF.cur_script_id), tostring(file)))
	end

	return path
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
						if v.name ~= v.root then 
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

--复制实例并加入数据库中(id不同)
function GF.CopyInst(o_inst,ot,o_inst_name)
	-- 赋值实例
	local itm = o_inst_name or {}
	local itemname
	if o_inst_name ~= nil then
		itemname  = itm.name
	end 
	GF.deepCopyInst(o_inst,itm,ot)
	if itemname ~= nil then 
		itm.name = itemname  
	end 

	-- 将实例加入数据库
	local key = o_inst.root
	local dbname = GF.GetTextOwner(key >> 16)
	local db = GF.DBLoad(dbname)
	if db then
		GF.QueryInit(dbname)
		if not o_inst_name  then 
			local inst_id = GF.NewTextID(dbname)
			local num = GF.QuerySize(dbname)
			itm.name = inst_id
			--GF.SetText(inst_id, GF.T(o_inst.name))
			-- itm.id = num + 1
			GF.newinst[dbname][#GF.newinst[dbname]+1] = itm
			GF.newinst_cache[dbname][inst_id] = itm
			-- itm.class = nil 
		end 
	end 
	--itm.traceback = debug.traceback()
	return itm
end 