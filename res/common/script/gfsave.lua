local GF = require "gfbase"
GF.static_config = require('static_config')
local co = require 'co'
local js = require 'cjson.c'
local save_o_list
-- local save_o_listp= 'o_misc_round'
local cur_save_file
GF.cur_script_id = 0x103c0001
-- local quit_save = false
-- local Version = 1.04				-- 游戏版本
-- local week_ver = '0.0.0.1'			-- 周目版本
-- GF.load_file_num = 0
local save_phase
local save_extra_data
local global_save_old = {}			-- 全局信息存储, 重构前的数据存储，暂且保留
local global_save = {}              -- 全局信息存储, 重构后的数据
local global_config = {}			-- 全局配置存储
local int_script_savenum = 4		-- 每章剧本的存档数
GF.mainThreadEventList = {}
GF.EventSaveName = {}
GF.needLoadEventFile = true
-- 自动更新
table.insert(GF.update, function(t, k)
	if save_phase == 1 then
		save_phase = nil
		if GF.GetCanSave() and not GF.call('动画是否正在播放') then
			GF.log('save start')
			GF.Save()
			GF.trig_event('saved')
			GF.log('save over')
		else
			GF.trig_event('saved')
		end
		return
	end
	if GF.verify_save == true then
		GF.Save(nil, true)
		GF.verify_save = nil
	end
end)

-- 获取档案信息
-- @params(int)  idx: 存档编号
-- @return(table)  返回该存档的档案信息, 若未找到, 则返回 nil
function GF.GetSaveInfo(idx)
	local save_info
	local save_path
	local buf

	save_info = {}
	-- 从文件中读取
	save_path = GF.GetSavePath(idx)
	buf = GF.LoadFile(save_path)
	if buf then
		buf = GF.unzip(buf)
		eris.settings("path", true)
		local ret, err = pcall(eris.unpersist, buf)
		if ret == false and err then
			GF.log(err)
			save_info = GF.RecoverSaveInfo(idx)
		else
			save_info = eris.unpersist({}, buf)
		end
	end
	return save_info
end

-- 恢复档案信息
-- @params(int)  idx: 存档编号
function GF.RecoverSaveInfo(idx)
	local recover_info = {}
	local save_path
	local fs
	local len
	local pos
	local file_name
	-- {['name'] = name, ['verified'] = false}
	for i = 0, 9 do
		file_name = tostring(idx)..'_'..tostring(i)
		save_path = GF.GetSavePath(file_name)
		fs = io.open(save_path, 'r')
		if fs then
			len = fs:seek('end')
			pos = 0
			if #recover_info == 0 then
				pos = 1
			else
				for i = 1, #recover_info do
					if recover_info[i].len < len then
						pos = i
						break
					end
				end
				if pos == 0 then
					pos = #recover_info + 1
				end
			end
			table.insert(recover_info, pos, {['name'] = file_name, ['verified'] = true, ['len'] = len})
			fs:close()
		end
	end
	GF.WriteSaveInfo(idx, recover_info)
	return recover_info
end

-- 将档案信息写入文件
-- @params(int)  idx: 存档编号
-- @params(table)  save_info: 存档信息
function GF.WriteSaveInfo(idx, save_info)
	local buf
	local path
	if type(save_info) ~= 'table' then
		GF.errorLog('Error! Attempt to write empty save info file: '..tostring(idx))
		return
	end
	-- 写入档案信息
	buf = eris.persist({}, save_info)
	path = GF.GetSavePath(idx)
	buf = GF.zip(buf)
	GF.WriteFile(path, buf)
end

-- 删除本地档案信息文件
-- @params(int)  idx: 存档编号
function GF.DeleteSaveInfo(idx)
	local path
	path = GF.GetSavePath(idx)
	-- 删除本地档案信息文件
	GF.RemoveFile(path)
end

-- 获取可用存档名称
-- @params(int)  idx: 存档编号
-- @params(table)  save_info: 档案信息(可选)
-- @return(string)  返回存档名称
function GF.GetSaveName(idx, save_info)
	local name
	save_info = save_info or GF.GetSaveInfo(idx)
	if #save_info < 10 then
		-- 如果命名还未用完, 则依序递增
		name = tostring(idx)..'_'..tostring(#save_info)
		table.insert(save_info, 1, {['name'] = name, ['verified'] = false})
	else
		-- 若命名已用完, 则使用最旧的存档的名称
		name = save_info[10].name
		table.insert(save_info, 1, {['name'] = name, ['verified'] = false})
	end
	GF.WriteSaveInfo(idx, save_info)
	return name
end

-- 存档
-- @params(int)  idx: 存档编号
-- @params(boolean)  verified: 存档真假性(是否经过验证)
function GF.Save(idx, verified)
	local save_name
	local save_info
	if GF.misc().nosave then
		return
	end
	verified = verified or false
	idx = idx or GF.GetCurSaveIdx()
	save_info = GF.GetSaveInfo(idx)
	if verified then
		-- 如果是有效存档, 直接获取最新存档名
		if save_info[1] then
			save_name = save_info[1].name
			save_info[1].verified = verified
		else
			return
		end
	else
		-- 如果是无效存档, 通过接口获取存档名
		save_name = GF.GetSaveName(idx, save_info)
		-- 如果有额外信息, 将额外信息写入文件
		if type(save_extra_data) == 'table' then
			for k, v in pairs(save_extra_data) do
				if k ~= 'name' and k ~= 'verified' then
					save_info[1][k] = v
				end
			end
			save_extra_data = nil
		end
		GF.verify_save = false
	end
	-- 将这个主存档设置为这个存档
	save_info['main_save'] = save_name
	if not verified then
		-- 如果是储存无效存档, 写入存档信息, 如果是有效存档, 则只需要更新档案信息
		GF.WriteSaveFile(save_name)
	end
	-- 写入档案配置信息
	-- GF.SetSvnversion()
	GF.WriteSaveInfo(idx, save_info)
	if not verified then
		GF.Save(nil, true)
	end
end

-- 删除存档
-- @params(int)  idx: 存档编号
-- @params(string)  save_name: 存档名称
-- @params(table)  save_info: 档案信息(可选)
function GF.DeleteSave(idx, save_name, save_info)
	local path
	save_info = save_info or GF.GetSaveInfo(idx)
	for i = 1, #save_info do
		if save_info[i].name == save_name then
			-- 从配置信息中删除该存档
			table.remove(save_info, i)
			-- 从本地文件中删除该存档
			path = GF.GetSavePath(save_name)
			GF.RemoveFile(path)
			-- 如果该档案信息中没有存档信息, 则删除档案信息文件
			if #save_info == 0 then
				GF.DeleteSaveInfo(idx)
			else
				-- 如果当前主存档是删除的存档, 则更新主存档
				if save_info['main_save'] == save_name then
					save_info['main_save'] = save_info[1].name
				end
				-- 写入档案信息
				GF.WriteSaveInfo(idx, save_info)
			end
			break
		end
	end
end

-- 完全删除指定编号的存档
-- @params(int)  idx: 存档编号
function GF.FullDeleteSave(idx)
	local save_info
	save_info = GF.GetSaveInfo(idx)
	for i = #save_info, 1, -1 do
		GF.DeleteSave(idx, save_info[i].name, save_info)
	end
	global_save_old['存档信息'][tostring(GF.cur_script_id)][idx] = {}
	GF.SaveGlobalInfo()
	GF.trig_event('save_delete', idx)
end

-- 读档
-- @params(int)  scriptid: 剧本编号
-- @params(int)  idx: 存档编号
-- @params(table)  verified_data: 验证数据
function GF.Load(scriptid, idx, verified_data)
	local save_info
	local save_name
	GF.cur_script_id = scriptid
	save_info = GF.GetSaveInfo(idx)
	GF.SetCurSaveIdx(idx)

	if #save_info == 0 then
		GF.errorLog('Error! Attempt to load nonexistent save file: '..tostring(idx))
		return false
	end
	for i = 1, #save_info do
		if type(verified_data) == 'table' then
			local verified = true
			for k, v in pairs(verified_data) do
				if save_info[i][k] ~= v then
					verified = false
					break
				end
			end
			if verified then
				save_name = save_info[i].name
			end
		else
			save_name = save_info[i].name
		end
		if save_name and GF.LoadSaveFile(save_name) then
			GF.MISC = GF.misc()
			GF.LoadEventFile(save_name)
			GF.call('系统_还原界面')
			return true
		end
	end
	return false
end
local perms = nil
-- 将存档内容写入存档文件
-- @params(string)  save_name: 存档文件名称
function GF.WriteSaveFile(save_name)
	local start_time = os.clock()

	local obj
	local objp
	local ui
	local t
	local mod_l
	local buf
	local path
	local zipbuf
	local objpp
	if perms == nil then
		perms = {
			[_ENV] = "_ENV",
			-- [c] = 1,
			[co] = 2,
			[co.yield] = 3,
			[co.resume] = 4,
			[GF] = 5,
			[xpcall] = 6,
			[GF.o_meta] = 7,
			[GF.new_meta] = 8,
		}
		eris.settings("path", true)
		for k,v in pairs(GF.api) do
			perms[v] = k
		end
		for k,v in pairs(GF) do
			local tp = type(v)
			if tp == 'function' then
				perms[v] = '_GF_'..k
			end
		end
	end
	obj = GF.save_ofile(save_o_list, 1)
	objp = GF.save_ofile(GF.static_config.save_o_listp)
	ui = nil--GF.save_ui()
	mod_l = tonumber(GF.gameMode())
	if mod_l and mod_l > 0 and mod_l < 5 then
		GF.log('--== 周目结束')
		t = {nil,nil ,nil, objp, nil, GF.GetQuitSave(), GF.getGameVersion(), nil}
	else
		t = {GF.srED, ui, obj, objp, GF.projdata, GF.GetQuitSave(), GF.getGameVersion()}
	end
	buf = eris.persist(perms, t)

	if GF.isServer() then
		GF.req_save(buf)
	else
		path = GF.GetSavePath(save_name)
		zipbuf = GF.zip(buf)
		GF.WriteFile(path, zipbuf)
		GF.EventSaveName[save_name] = #GF.mainThreadEventList
	end
	GF.SaveGlobalInfo()
	print('save spend time:',os.clock() - start_time)
	-- GF.mainThreadEventList = {}
	--GF.WriteEventFile()
end
function GF.WriteEventFile()
	-- print('WriteEventFile',debug.traceback())
	-- local idx = GF.GetCurSaveIdx()
	-- if true then return end
	-- for i=1,#GF.mainThreadEventList do
	-- 	print('save event:',i,table.unpack(GF.mainThreadEventList[i]))
	-- end
	-- local buf = eris.persist(perms, GF.mainThreadEventList)
	-- local path = GF.GetSavePath(idx .. '_event')
	-- GF.WriteFile(path, buf)
end
function GF.LoadEventFile(savename)
	local st = os.clock()
	GF.needLoadEventFile = false
	if GF.EventSaveName[savename] == nil then GF.EventSaveName[savename] = 0 end
	print('LoadEventFile is doing',#GF.mainThreadEventList)
	GF.log('LoadEventFile is doing',#GF.mainThreadEventList)
	GF.SetCanSave(false)
	local start = GF.EventSaveName[savename] + 1
	local t = 30
	local endindex = start
	for i=#GF.mainThreadEventList,start,-1 do
		if GF.mainThreadEventList[i][1] == '系统_计数式战斗前存档请求' then
			endindex = i
			break
		end
	end
	for i = #GF.mainThreadEventList,endindex ,-1 do
		table.remove(GF.mainThreadEventList,i)
	end
	for i=start,#GF.mainThreadEventList do
		if GF.mainThreadEventList[i][1] ~= '系统_计数式战斗前存档请求' then
			print('load event:',i,table.unpack(GF.mainThreadEventList[i]))
			local tlist = {}
			for j=1,#GF.mainThreadEventList[i] do
				local temp = GF.mainThreadEventList[i][j]
				if temp and type(temp) == 'number' and GF.QueryName(temp) then
					tlist[j] = GF.QueryName(temp)
				else
					tlist[j] = temp
				end
			end
			GF.trig_event(table.unpack(tlist))
			GF.main(1)
			while #GF.srED.event > 0 or GF.FindAction('update_等待所有动画结束') do
				GF.main(t)
				t = t + 300
				if #GF.srED.mono_wait > 0 then
					break
				end
			end
		end
	end
	GF.needLoadEventFile = true
	GF.SetCanSave(true)
	print('事件读档耗时：' , os.clock() - st)
end
-- 读取存档文件
-- @params(string)  save_name: 存档文件名称
function GF.LoadSaveFile(save_name)
	local path
	local buf
	GF.SetQuitSave(true)
	path = GF.GetSavePath(save_name)
	buf = GF.LoadFile(path)
	if not buf then
		GF.errorLog('Error! Attempt to load nonexistent save file: '..tostring(save_name))
		return false
	end
	local res = GF.LoadBuff(buf)
	if res then
		GF.InitSaveInfo()
		GF.ClearEventQueue()
		GF.trig_event("loaded", GF.GetCurSaveIdx())
		GF.trig_event("saved", GF.GetCurSaveIdx())
		GF.trig_event('所有动画播放结束')
		GF.trig_event('界面_关闭月度演化')
	end
	--GF.LogEventInfo()
	return res
end

-- 将 LoadSaveFile 分隔成 LoadFile和LoadBuff，LoadBuff用于本地和云端共用
--  @params(string) buf: binary load info
function GF.LoadBuff(buf)
	local t
	local uperms = {
		_ENV = _ENV,
		-- [1] = c,
		[2] = co,
		[3] = co.yield,
		[4] = co.resume,
		[5] = GF,
		[6] = xpcall,
		[7] = GF.o_meta,
		[8] = GF.new_meta,
	}
	buf = GF.unzip(buf)
	eris.settings("path", true)
	for k,v in pairs(GF.api) do
		uperms[k] = v
	end
	for k,v in pairs(GF) do
		local tp = type(v)
		if tp == 'function' then
			uperms['_GF_'..k] = v
		end
	end
	local ret, err = pcall(eris.unpersist, uperms, buf)
	if ret == false and err then
		GF.log(err)
		return false
	end
	t = eris.unpersist(uperms, buf)
	if t[3] ~= nil then
		--if not is_save_version_correct(t[3]) then
		--	return false
		--end
		GF.load_ofile(t[3])
	end
	if t[5] ~= nil then GF.projdata = t[5] end
	if t[1] ~= nil then GF.srvEventData(t[1]) end
	-- quit_save = t[6]
	GF.SetQuitSave(t[6])
	-- test_load_ofile(t[3])
	GF.load_ofile_single(GF.static_config.save_o_listp,t[4])
	GF.MISC = GF.misc()
	if t[2] ~= nil then GF.load_ui(t[2] )end
	GF.call('upgrade', t[7])
	return true
end

function is_save_version_correct(obj)
	local newinst_cache = obj[1]
	local o_misc = newinst_cache['o_misc'][0x100f0001]
	local any_折扣表

    any_折扣表 = o_misc.道具生成渠道折扣表
    if type(any_折扣表) ~= 'table' then
        return false
    end

    for k, v in pairs(any_折扣表) do
        if type(k) == 'number' then
            return false
        end
    end

    return true
end

-- 清空游戏数据的 require 缓存
function GF.ResetSave()
	for k,v in pairs(package.loaded) do
		if string.find(k,'o_') == 1 then
			package.loaded[k] = nil
		end
	end
end

-- 设置存档阶段, 将在下一帧开始存档
-- @params(table)  extra_data: 需要写入文件的额外数据
function GF.PrepareSave(extra_data)
	save_extra_data = extra_data
	save_phase = 1
end

-- 获取存档文件的位置
-- @params(string)  file: 文件的名称
-- @return(string)  返回所在位置
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
-- 存档添加 svn的记录
-- @params(string)  file: 文件的名称
function GF.SetSvnversion()
	local path = GF.GetSavePath('Svnversion.csv')
	local version = require('version')
	print(path)
	local file
	if GF.IsFileExist(path) then
		file = io.open(path,'a')
	else
		GF.WritePath(path)
		file = io.open(path,'a')
		if file then
			file:write("安卓版本号,客户端svn,编辑器svn,是否手机包\n")
		end
	end
	-- GF.WritePath(path)
	-- GF.MakeDirIfNotExist(path)
	-- local file = io.open(path,'a')
	-- file:write("安卓版本号,客户端svn,编辑器svn,是否手机包\n")
	local str = ''
	if GF.GetOS() == 1 then
		str = str .. version.version .. ','
		-- str = str .. GF.getGameVersion() .. ','
		local t = io.popen('svn info '..GF.GetWorkDir()..'/project/dreamland')
		for i in t:lines() do
			if string.find( i,'Revision:' ) then
				local beg,en = string.find( i,'Revision:' )
				str = str .. string.sub( i,en +2 ) .. ','
				break
			end
		end
		local t = io.popen('svn info '..GF.GetWorkDir())
		for i in t:lines() do
			if string.find( i,'Revision:' ) then
				local beg,en = string.find( i,'Revision:' )
				str = str .. string.sub( i,en +2) .. ','
				break
			end
		end
		str = str .. ' '
	else
		str = str .. version.version .. ','
		str = str .. version.Svnversion_Dreamland .. ','
		str = str .. version.Svnversion_Editor .. ','
		str = str .. 'true'
	end
	print(str)
	if (file) then
		file:write( str .. "\n" );
		file:close()
	end
	return path
end
-- 创建目录
-- @params(string)  filepath: 路径
function GF.MakeDirIfNotExist(filepath)
	local root_path = GF.WritePath(filepath)
	if not GF.IsDirExist(root_path) then
		GF.MakeDir(root_path)
	end
end

-- 设置退出存档属性
-- @params(boolean)  save: 是否退出存档
function GF.SetQuitSave(save)
	collectgarbage("collect")
end

function GF.GetQuitSave(save)
	return true
end
-- 设置能否存档属性
-- @params(boolean)  save: 是否开启存档功能
function GF.SetCanSave(save)
	GF.misc().can_save = save
end

-- 获取存档功能是否开启
-- @return(boolean)  返回是否开启存档功能
function GF.GetCanSave()
	return GF.misc().can_save
end

-- 获取当前剧本
function GF.GetCurScript()
	return GF.cur_script_id
end

-- 设置当前剧本
function GF.SetCurScript(int_scriptid)
	GF.cur_script_id = int_scriptid
end

-- 获取当前使用的存档编号
function GF.GetCurSaveIdx()
	return cur_save_file
end

-- 设置当前使用的存档编号
-- @params(int)  idx: 当前存档编号
function GF.SetCurSaveIdx(idx)
	cur_save_file = tonumber(idx)
end

-- 使用新的存档编号开始游戏
-- @params(int)  idx: 存档编号
function GF.NewSave(scriptid,idx)
	GF.cur_script_id = scriptid
	GF.SetCurSaveIdx(idx)
end

-- 初始化存档信息
-- @params(string)  buf: 文件内容
-- @params(_scriptobj)  o1: 数据文件
-- @params(_scriptobj)  o2: 跨周目文件
function GF.InitSaveInfo()
	local buf = nil
	local uperms = {
		_ENV = _ENV,
		-- [1] = c,
		[2] = co,
		[3] = co.yield,
		[4] = co.resume,
		[5] = GF,
		[6] = xpcall,
		[7] = GF.o_meta,
		[8] = GF.new_meta,
	}

	-- 初始化全局存档信息
	GF.ClearGlobalSave()

	-- 加载globalsave.json,读取全局存档信息
	local filename = GF.GetSavePath("/../globalsave.json")
	local file = io.open( filename, "rb" );
	if (file) then
		buf = file:read('*all')
		file:close()
	end

	-- 如果这个文件不存在,那么写入一个空的
	if not buf or #buf <= 0 then
		buf = '{}'
		-- return false
	end

	-- 解析json
	local globalsaveinfo = js.decode(buf)
	local global_listpp = globalsaveinfo['global']
	if ( global_listpp ~= nil ) then
		for k,v in pairs(global_listpp) do
			global_save_old[k] = v
		end
		-- 在 global_save 中的数据，从 global_save_old 中剔除
		for k,v in pairs(global_save) do
			global_save_old[k] = nil
		end
	end

	return true
end

--==------------------- 全局存储相关,globalsave.json ---------------------------------------------------------
--== GlobalSave的主要作用是存储所有剧本的存档的一些通用信息,诸如存档时间,江湖时间,周目等,未来是需要随同具体的存档一同上传服务器的

-- 对外接口,获取某一个key值的全局信息
function GF.GetGlobalValue(key)
	if (key == nil) then
		return nil
	end

	-- 容错编辑器
	if next(global_save) == nil then
		-- GF.DeserializeGlobalSave()
		global_save[key] = {}
		return global_save[key]
	end
	if global_save[key] then
		return global_save[key]
	end
	return global_save_old[key]
end

-- 对外接口,设置某一个key值的全局信息
function GF.SetGlobalValue(key,value)
	if ( key == nil ) then
		return nil
	end
	if global_save[key] then
		global_save[key] = value
		return
	end
	global_save_old[key] = value
end

-- 内部接口,存储全局存档信息,当存档的时候自动调用一次全局存档信息存储
function GF.SaveGlobalInfo()
	local globalsaveinfo = {['version'] = GF.static_config.Version,['global'] = global_save_old}
	-- 将lua表encode成json
	local globalinfo = js.encode(globalsaveinfo)
	-- 存储到文件globalsave.json中
	local string_Savepath = GF.GetSavePath("/../globalsave.json")
	GF.WriteFile(string_Savepath,globalinfo)
end

-- 设置全局存档信息
function GF.SetGlobalSaveInfo(scriptid, idx, key, value)
	-- 安全性处理
	if ( scriptid == nil or idx == nil or key == nil or
			idx <= 0 or idx > int_script_savenum) then
		GF.log('[GFSave]->Error,SetGlobalSaveInfo Error!')
		return
	end

	GF.ClearGlobalSave()

	-- 判断此剧本的存档是否存在
	local string_scriptid = tostring(scriptid)
	local saveinfo = global_save_old['存档信息'][string_scriptid]
	if ( saveinfo == nil or saveinfo[idx] == nil ) then
		global_save_old['存档信息'][string_scriptid] = {}
		for int_i = 1,int_script_savenum do
			table.insert(global_save_old['存档信息'][string_scriptid],{})
		end
	end

	-- 设置存档信息
	saveinfo = global_save_old['存档信息'][string_scriptid][idx]

	saveinfo[key] = value
end

-- 初始化全局信息
function GF.ClearGlobalSave()
	if ( global_save_old ~= nil and next(global_save_old) ~= nil ) then
		return
	end
	global_save_old = { RunOnce = true }
	global_save_old['存档信息'] = {}
	GF.DeserializeGlobalSave()
end

-----------------------------全局数据的序列化和反序列化（临时实现）-----------------------------
local gsmap_key_bool = {
	'成就完成', '图鉴完成', '第一次引导', '引导完成', '已搜集门派', '已搜集武学', '已搜集天赋',
	'已搜集物品', '已搜集角色', '已搜集立绘', '已搜集模型', '已搜集角色品质', '武学ugc解锁素材',
	'帐号第一次执行', '门派完成',
}
local gsmap_key_map = {"队员完成",}

-- 将o表数据反序列化到内存，存到 global_save 中
function GF.DeserializeGlobalSave()
	local g = require('o_globalsave') [2][1]
	local gs = GF.QueryIndex("o_globalsave", 1)

	-- 把表的数据存到内存 global_save 中
	for name, _ in pairs(g) do
		global_save[name] = gs[name]
	end

	-- -- 为了提高查询效率，将数组转换成字典
	for _, name in pairs(gsmap_key_bool) do
		global_save[name] = {}
		for _, v in ipairs(gs[name]) do
			global_save[name][v] = true
		end
	end

	for _, name in pairs(gsmap_key_map) do
		global_save[name] = {}
		for _, v in ipairs(gs[name]) do
			global_save[name][v.id] = v
		end
	end
end

-- 将内存中的数据序列化到o表准备存盘
function GF.SerializeGlobalSave()
	local g = require('o_globalsave') [2][1]
	local gs = GF.QueryIndex("o_globalsave", 1)

	for name, _ in pairs(gs) do
		gs[name] = global_save[name]
	end

	for _, name in pairs(gsmap_key_bool) do
		gs[name] = {}
		for k, _ in pairs(global_save[name]) do
			table.insert(gs[name], k)
		end
	end
end
-----------------------------全局数据的序列化和反序列化（临时实现）-----------------------------


-- 删除存档

--==------------------- 本地配置相关,Config.json ---------------------------------------------------------
--== Config.json主要保存本地的一些信息,诸如音量大小,上次选择的服务器等

-- 对外接口,设置配置项
function GF.SetConfig(key,value)
	local path = GF.WritePath("save/config/")
	local filename = path .. 'config.json'
	-- 设置配置项
	global_config[key] = value
	-- 再保存配置文件
	local global_configinfo = js.encode(global_config)
	GF.WriteFile(filename,global_configinfo)
end

-- 对外接口,获取配置项
function GF.GetConfig(key)
	return global_config[key]
end

-- 对外接口,初始化全局配置信息
function GF.Init_GlobalConfig()


	global_config = {}
	GF.MakeDirIfNotExist("save/")
	GF.MakeDirIfNotExist("save/config")
	-- 先读取配置文件,加载配置项
	local path = GF.WritePath("save/config/")
	local filename = path .. 'config.json'
	local file = io.open( filename, "rb" );
	if (file) then
		local buf = file:read('*all')
		if (not buf or #buf <= 0) then
			buf = '{}'
		end
		-- 解析json
		global_config = js.decode(buf)
		file:close()
	end
	local global_configinfo = js.encode(global_config)
	GF.WriteFile(filename,global_configinfo)
end

--==------------------- 局部函数 ---------------------------------------------------------
local clear_table
clear_table = function(t,savet,names)
	if type(t) == 'table' and savet[t] == nil then
		savet[t] = true
		if t[names] and type(t[names]) == 'table' and #t[names] > 0 then
			for i=#t[names],1,-1 do
				local sname = t[names][i].名称.name
				if sname and t[names][i].名称 ~= GF.newinst_cache['o_role'][sname] then
					t[names][i].名称 = GF.newinst_cache['o_role'][sname]
				end
			end
		end
		for k,v in pairs(t) do
			clear_table(v,savet,names)
		end
	end
end
function GF.save_ofile(o_list)
	if type(o_list) == 'string' then
		clear_table(GF.newinst_cache[o_list],{},'关系链')
		return GF.newinst_cache[o_list]
	end
	clear_table(GF.newinst_cache,{},'关系链')
	return {GF.newinst_cache,GF.extinst}
end
function GF.load_ofile_single(o_name,v)
	if v == nil then return end
	local db = require(o_name)
	GF.QueryInit(o_name)
	GF.newinst_cache[o_name] = v
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

--==--------- 临时代码 ----------------------------------------------------------------
function GF.save_test(file)
	local perms = {
		[_ENV] = "_ENV",
		-- [c] = 1,
		[co] = 2,
		[co.yield] = 3,
		[co.resume] = 4,
		[GF] = 5,
		[xpcall] = 6,
		[GF.o_meta] = 7,
		[GF.new_meta] = 8,
	}
	local _data = save_o_list
	local tab
	local t
	local path
	local buf
	local obj = GF.save_ofile(save_o_list)
	local objp = GF.save_ofile(GF.static_config.save_o_listp)
	local ui = GF.save_ui()
	tab = {obj}
	t = {tab}
	buf = eris.persist(perms, t)
	path = GF.GetSavePath(file .. "_obj" )
	GF.WriteFile(path, buf)
	for i ,v in pairs(obj) do
		tab = {v}
		t = {tab}
		buf = eris.persist(perms, t)
		path = GF.GetSavePath(file .. "_"..i)
		GF.WriteFile(path, buf)
	end
	tab = {GF.srED}
	t = {tab}
	buf = eris.persist(perms, t)
	path = GF.GetSavePath(file.."__GF_srED")
	GF.WriteFile(path, buf)
	tab = {GF.srED['event']}
	t = {tab}
	buf = eris.persist(perms, t)
	path = GF.GetSavePath(file .. "_event")
	GF.WriteFile(path, buf)
	tab = {GF.srED['wait']}
	t = {tab}
	buf = eris.persist(perms, t)
	path = GF.GetSavePath(file .. "_wait")
	GF.WriteFile(path, buf)
	tab = {GF.srED['name']}
	t = {tab}
	buf = eris.persist(perms, t)
	path = GF.GetSavePath(file .. "_name")
	GF.WriteFile(path, buf)
	tab = {GF.srED['last_arg']}
	t = {tab}
	buf = eris.persist(perms, t)
	path = GF.GetSavePath(file .. "_last_arg")
	GF.WriteFile(path, buf)
	tab = {GF.srED['co_pool']}
	t = {tab}
	buf = eris.persist(perms, t)
	path = GF.GetSavePath(file .. "_co_pool")
	GF.WriteFile(path, buf)
	tab = {GF.srED['mono_run']}
	t = {tab}
	buf = eris.persist(perms, t)
	path = GF.GetSavePath(file .. "_mono_run")
	GF.WriteFile(path, buf)
	tab = {GF.srED['mono_wait']}
	t = {tab}
	buf = eris.persist(perms, t)
	path = GF.GetSavePath(file .. "_mono_wait")
	GF.WriteFile(path, buf)
	tab = {GF.srED['pending_start']}
	t = {tab}
	buf = eris.persist(perms, t)
	path = GF.GetSavePath(file .. "_pending_start")
	GF.WriteFile(path, buf)
	tab = {GF.srED['pending_running']}
	t = {tab}
	buf = eris.persist(perms, t)
	path = GF.GetSavePath(file .. "_pending_running")
	GF.WriteFile(path, buf)
end

local temp_oname
local file
local tableee = {}
local setrolenil

function test_load_ofile(obj)
	for o_name,v in pairs(obj) do
		-- if o_name == 'o_item'  then
			file = io.open('save/'..o_name .. '.log', 'w')
			file:write(o_name..'\n');
			-- test_show_index(v,1)
			-- GF.show_table(v,file)
			file:close()
		-- end
	end
end

function test_show_index(obj,num)
	-- if num > 10 then return end
	if type(obj ) == 'table'  and obj ~= nil then
		if obj['n'] then
			test_out_oname(0, '{')
			file:write('n=' .. obj['n']  .. ",");
		else
			test_out_oname(0, '{\n')
		end
		-- test_out_oname (num,'{\n')
		if num > 3 and obj.name  then
			test_out_oname(num,obj.name,'\n')
			test_out_oname(num, '}\n')
			return
		end
		-- if obj['n'] then
		-- 	file:write('n=' .. obj['n']  .. ",\n");
		-- endand o_name ~= 'cache'
		local temp_num = 0
		for o_name,li in pairs(obj) do
			if o_name  ~= 'n'and o_name ~= 'cache' and o_name ~= 'skillstack'  then
				temp_num  = num
				if tonumber(o_name ) then
					if obj['n'] and  o_name == 1 then
						temp_num = 0
					end
					o_name  = '[' .. o_name .. '] = '
				else
					o_name = '[\'' .. o_name .. '\'] = '
				end
				if type(li) == 'table' then
					test_out_oname(temp_num , o_name)
					test_show_index(li,  num + 1)
				elseif type(li) == 'string' then
					test_out_oname(temp_num , o_name, li)
					file:write('\n');
				elseif type(li) == 'boolean' then
					test_out_oname(temp_num , o_name, tostring(li))
					file:write('\n');
				elseif type(li) == 'number' then
					test_out_oname(temp_num , o_name, li)
					file:write('\n');
				end
				-- file:write('\n');
			end
		end
		test_out_oname(num, '}\n')
	end
end

function test_out_oname(num, ...)
	local s = {...}
	local str = ''
	for i = 1, num do
		str = str .. '\t'
	end
	for i = 1, #s do
		if type(s[i]) == 'number' and #GF.ToHexString(s[i]) == 8 then
			str = str .. '0x' .. GF.ToHexString(s[i]) .. '--'
			local inde = tonumber('0x' .. GF.ToHexString(s[i]))
			if GF.T(inde)  then
				str = str ..GF.T(inde)
			end
		else
			str = str .. tostring(s[i]) .. " "
		end
	end
	file:write(str);
	file:flush()
end

function GF.test_log_newctx()
	local newe = GF.srED
	for o_name,v in pairs(newe ) do
		file = io.open('save/'..o_name .. '.log', 'w')
		tableee  = {}
		file:write(o_name..'\n');
		test_show_newctx(v,1)
		file:close()
	end
end

function test_show_newctx(obj, num)
	if obj == nil then return end
	if type(obj) == 'table'  then
		test_out_newctx(num,'{')
		if num > 1 and obj.name  then
			test_out_newctx ( num,obj.name ,'--',GF.T(obj.name) )
			test_out_newctx(num, '}')
			return
		end
		for o_name,li in pairs(obj) do
			-- test_out_newctx(num,o_name ,li,GF.srED.name[li])
			test_show_newctx(li,num + 1)
		end
		test_out_newctx(num, '}')
	elseif type(obj) == 'thread' then
		-- test_out_newctx(num, tostring(obj))
		test_out_newctx(num, obj , GF.srED.name[obj])
	else
		test_out_newctx(num, tostring(obj))
	end

end

function test_out_newctx(num, ...)
	local s = {...}
	local str = ''
	for i = 1, num do
		str = str .. '\t'
	end
	for i = 1, #s do
		if type(s[i]) == 'number' and #GF.ToHexString(s[i]) == 8 then
			str = str .. '0x' .. GF.ToHexString(s[i])
		else
			str = str .. tostring(s[i]) .. " "
		end
	end
	file:write(str .. "\n");
	file:flush()
end

function GF.show_table_log()
	test_load_ofile(save_ofile(save_o_list))
end

-- 保存出错状态
-- @params(boolean)  err: 是否出错
function GF.SetErrorState(err)
	GF.errorState = err
end


------------------------------------------------平台信息 start------------------------------------
local save_name = "save"
local global_name = 'globalInfo'
-- 初始化平台信息
function GF.InitGlobalInfo(globalInfo)
	-- 注意：没连接上服务器时需要先使用本地的信息，给登录界面显示用
	if globalInfo == nil then
		local path = GF.GetPlayerInfoPath(global_name)
		globalInfo = GF.LoadFile(path)
	end
	if globalInfo and globalInfo ~= '' then
		perms = {
			[_ENV] = "_ENV",
			[GF] = 5,
			[xpcall] = 6,
		}
		local buf = eris.unpersist(perms, globalInfo)
		global_save = buf
	else
		global_save = {
			['成就完成']={},
			['图鉴完成']={},
			['第一次引导']={},
			['引导完成']={},
			['已搜集门派']={},
			['已搜集武学']={},
			['已搜集天赋']={},
			['已搜集物品']={},
			['已搜集角色']={},
			['已搜集立绘']={},
			['已搜集模型']={},
			['已搜集角色品质']={},
			['武学ugc解锁素材']={},
			['周目信息']={},
			['武学上限']={},
			['帐号第一次执行']={},
			['已上传自创武学']={},
			['门派完成']={},
			['队员完成']={},
			['配方完成']={},
			['传家宝完成']={},
			['已解锁剧本']={},
			['已通关剧本']={},
			['难度系数']={},
			['解锁剧本难度']={},
			['平台仓库物品']={},
			['存档信息']={},
			['门派阶段']={},
			['叠加等级信息']={},
			['创角解锁']={},
			['心愿任务完成信息']={},
			['孩子列表']={},
			['武学ugc上次秘籍生成时间']=0,
			['金元宝']=0,
			['帐号武学等级上限']=30,
			['自创武学数上限']=5,
			['自创武学最大个数']=5,
			['天宫锤']=0,
			['完美粉']=0,
			['精铁']=0,
			['生产熟练度']={},
		}
	end
end

-- 存储平台信息
function GF.GetSaveGlobalInfo()
	perms = {
		[_ENV] = "_ENV",
		[GF] = 5,
		[xpcall] = 6,
	}
	return eris.persist(perms, global_save)
end
-- 存储平台信息
function GF.SaveGlobalInfo()
	GF.log('SaveGlobalInfo start')
	local buf = GF.GetSaveGlobalInfo()
	local path = GF.GetPlayerInfoPath(global_name)
	-- local zipbuf = GF.zip(buf)
	GF.WriteFile(path, buf)
	GF.log('SaveGlobalInfo over')
end

-- 对外接口,获取某一个key值的全局信息
function GF.GetGlobalValue(key)
	if (key == nil) then
		return nil
	end

	-- 容错编辑器
	if global_save == nil or next(global_save) == false then
		-- GF.InitGlobalInfo()
		global_save[key] = {}
		return global_save[key]
	end

	if global_save[key] then
		return global_save[key]
	else
		GF.errorLog('[平台信息]->global_save ERROR! no key',key)
	end

end

-- 对外接口,设置某一个key值的全局信息
function GF.SetGlobalValue(key,value)
	if ( key == nil ) then
		return nil
	end
	if global_save[key] then
		global_save[key] = value
		return
	end
end

-- 对外接口,插入值
function GF.SetGlobalKeyValue(tname,key,value)
	if ( key == nil ) then
		return nil
	end
	if value == nil then value = true end
	if global_save[tname] then
		global_save[tname][key] = value
	end
end

-- 获取存档文件的位置
-- @params(string)  file: 文件的名称
-- @return(string)  返回所在位置
function GF.GetPlayerInfoPath(filename)
	local path
	GF.MakeDirIfNotExist("save/")
	if type(GF.get_isconnect) == 'function' and GF.get_isconnect() and GF.player_id then
		GF.MakeDirIfNotExist("save/netplay")
		GF.MakeDirIfNotExist('save/netplay/' .. tostring(GF.player_id))
		path = GF.WritePath(string.format("save/netplay/%s/%s", tostring(GF.player_id), tostring(filename)))
	else
		GF.MakeDirIfNotExist("save/single")
		path = GF.WritePath(string.format("save/single/%s",tostring(filename)))
	end

	return path
end

-- 设置存档信息
function GF.SetSaveInfo(scriptid, idx, key, value)
	-- 安全性处理
	if ( scriptid == nil or idx == nil or key == nil or
			idx <= 0 or idx > int_script_savenum) then
		GF.log('[GFSave]->Error,SetSaveInfo Error!')
		return
	end

	local o_saveinfo_data = global_save['存档信息'][scriptid]
	if next(o_saveinfo_data) then
		o_saveinfo_data[key] = value
	else
		GF.errorLog('[GFSave]->Error,saveinfo is not init!',scriptid)
	end
end

-- 获取存档信息
function GF.GetSaveInfo(int_scriptid)
	if GF.is_editor then return end
	int_scriptid = int_scriptid or GF.GetCurScript()
	if not int_scriptid then
		GF.errorLog('InitSaveInfo ERROR!')
		return
	end
	return global_save['存档信息'][int_scriptid]
end

-- 删除存档信息
function GF.DeleteSaveInfo(int_scriptid)
	print('DeleteSaveInfo',int_scriptid)
	int_scriptid = int_scriptid or GF.GetCurScript()
	if not int_scriptid then
		GF.errorLog('InitSaveInfo ERROR!')
		return
	end
	global_save['存档信息'][int_scriptid] = nil
	return false
end

-- 初始化存档信息
function GF.InitSaveInfo()
	-- 初始化全局存档信息
	local int_scriptid = GF.GetCurScript()
	if not int_scriptid then
		GF.errorLog('InitSaveInfo ERROR!')
		return
	end
	local o_saveinfo_data =global_save['存档信息'][int_scriptid]
	if o_saveinfo_data then
		GF.DeleteSaveInfo(int_scriptid)
		-- GF.errorLog('[GFSave]->Error,save isnot delete!')
	end
	global_save['存档信息'][int_scriptid]={
		['金钱']=0,
		['红水晶']=0,
		['金绽']=0,
		['当前周目']=1,
		['难度系数']=1,
		['游戏时间']=0,
		['江湖时间']=0,
		['存档时间']=0,
		['剧本']=int_scriptid
	}
	return true
end