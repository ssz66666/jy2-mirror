local GF = require "gfbase"
GF.static_config = require('static_config')
local co = require 'co'
local js = require 'cjson.c'
local save_o_list
local save_phase
local save_extra_data
local global_save            -- 全局信息存储, 重构后的数据
local global_config = {}			-- 全局配置存储
local int_script_savenum = 4		-- 每章剧本的存档数
local save_name = "save"
local global_name = 'globalData'
GF.mainThreadEventList = {}
GF.EventSaveName = {}
GF.needLoadEventFile = true
local str_gs = string.gsub
local str_form = string.format
local str_find = string.find

-- 删除存档
-- @params(int)  idx: 存档编号
-- @params(string)  save_name: 存档名称
-- @params(table)  save_info: 档案信息(可选)
function GF.DeleteSave(i_script_id)
	local path
	path = GF.GetSavePath(save_name,i_script_id)
	GF.RemoveFile(path)
	GF.DeleteSaveInfo(i_script_id)
end

local perms = nil
-- 当前剧本存档
function GF.Save(i_script_id,int_id)
	local start_time = os.clock()
	local buf = GF.save_ofile()
	local path = GF.GetSavePath(save_name,i_script_id)
	local zipbuf = GF.zip(buf)
	GF.WriteFile(path, zipbuf)
	print('save spend time:',os.clock() - start_time)
	GF.SaveLeaveOSSRecord()
	if global_save['存档信息'][i_script_id or GF.cur_script_id] == nil then
		global_save['存档信息'][i_script_id or GF.cur_script_id] = GF.saveInfo
	end
	GF.saveInfo = nil
end

-- 服务器剧本存档
function GF.saveScriptData()
	if not SERVER_EVENT_SYNC then
		return
	end
	GF.call('杂项_记录存档时间')
	local buff = GF.save_ofile()
	if global_save['存档信息'][GF.cur_script_id] == nil then
		global_save['存档信息'][GF.cur_script_id] = GF.saveInfo
	end
	GF.saveInfo = nil
	return buff
end

-- 读取服务器存档数据
function GF.loadScriptData(data)
	if not SERVER_EVENT_SYNC then
		return false
	end
	GF.load_ofile(data)
	GF.cacheData = {}
	print('loadScriptData Done ',#data)
	return true
end

-- 读取本地存档数据
-- @params(string)  scriptid: 剧本id
function GF.getLocalScriptSave(scriptid)
	local start_time = os.clock()
	local path = GF.GetSavePath(save_name,scriptid)
	local buf = GF.LoadFile(path)
	if not buf then
		GF.errorLog('Error! Attempt to load nonexistent save file: '..tostring(save_name))
	end
	print('Load spend time:',os.clock() - start_time)
	return buf
end


-- 读取存档文件
-- @params(string)  scriptid: 剧本id
function GF.Load(scriptid)
	local buf = GF.getLocalScriptSave(scriptid)
	return GF.LoadBuff(buf,scriptid)
end

function GF.LoadBuff(loadbuff,scriptid)
	if loadbuff == nil or loadbuff == '' then
		loadbuff = GF.getLocalScriptSave(scriptid)
	end
	if loadbuff == nil then
		return false
	end
	local buf = GF.unzip(loadbuff)
	if buf == nil then
		return false
	end
	GF.load_ofile(buf)
	GF.cacheData = {}
	return true
end
-- 清空游戏数据的 require 缓存
function GF.ResetSave()
	-- for k,v in pairs(package.loaded) do
	-- 	if str_find(k,'o_') == 1 then
	-- 		package.loaded[k] = nil
	-- 	end
	-- end
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
		path = GF.WritePath(str_form("save/netplay/%s/%s", tostring(GF.player_id), tostring(filename)))
	else
		GF.MakeDirIfNotExist("save/single")
		path = GF.WritePath(str_form("save/single/%s",tostring(filename)))
	end

	return path
end
-- 获取存档文件的位置
-- @params(string)  file: 文件的名称
-- @return(string)  返回所在位置
function GF.GetSavePath(file,scriptid)
	scriptid = scriptid or GF.cur_script_id
	local path
	GF.MakeDirIfNotExist("save/")
	if type(GF.get_isconnect) == 'function' and GF.get_isconnect() and GF.player_id then
		GF.MakeDirIfNotExist("save/netplay")
		GF.MakeDirIfNotExist('save/netplay/' .. tostring(GF.player_id))
		GF.MakeDirIfNotExist("save/netplay/" .. tostring(GF.player_id) .. '/' .. tostring(scriptid))
		path = GF.WritePath(str_form("save/netplay/%s/%s/%s", tostring(GF.player_id),tostring(GF.cur_script_id), tostring(file)))
	else
		GF.MakeDirIfNotExist("save/single")
		GF.MakeDirIfNotExist("save/single/" .. tostring(GF.cur_script_id))
		path = GF.WritePath(str_form("save/single/%s/%s", tostring(scriptid), tostring(file)))
	end

	return path
end
-- 存档添加 svn的记录
-- @params(string)  file: 文件的名称
function GF.SetSvnversion()
	local path = GF.GetPlayerInfoPath('Svnversion.csv')
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
			if str_find( i,'Revision:' ) then
				local beg,en = str_find( i,'Revision:' )
				str = str .. string.sub( i,en +2 ) .. ','
				break
			end
		end
		local t = io.popen('svn info '..GF.GetWorkDir())
		for i in t:lines() do
			if str_find( i,'Revision:' ) then
				local beg,en = str_find( i,'Revision:' )
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

-- 获取当前剧本
function GF.GetCurScript()
	return GF.cur_script_id
end

-- 设置当前剧本
function GF.SetCurScript(int_scriptid)
	GF.cur_script_id = int_scriptid
end

------------------------------------------------存档信息 start------------------------------------
-- 初始化存档信息
function GF.InitSaveInfo()
	-- 初始化全局存档信息
	local int_scriptid = GF.GetCurScript()
	if not int_scriptid then
		GF.errorLog('InitSaveInfo ERROR!')
		return
	end
	local o_saveinfo_data = global_save['存档信息'][int_scriptid]
	if o_saveinfo_data then
		GF.DeleteSaveInfo(int_scriptid)
	end
	GF.saveInfo = {
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
	GF.cacheData = {}
	return true
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
	GF.SaveGlobalInfo()
	return false
end

-- 获取存档信息
function GF.GetSaveInfo(int_scriptid)
	if GF.is_editor then return end
	int_scriptid = int_scriptid or GF.GetCurScript()
	if not int_scriptid then
		GF.errorLog('InitSaveInfo ERROR!')
		return
	end
	if global_save['存档信息'][int_scriptid] then
		return global_save['存档信息'][int_scriptid]
	else
		return GF.saveInfo
	end
end

-- 设置存档信息
function GF.SetSaveInfo(scriptid, idx, key, value)
	-- 安全性处理
	if ( scriptid == nil or key == nil ) then
		GF.log('[GFSave]->Error,SetSaveInfo Error!')
		return
	end

	local o_saveinfo_data = global_save['存档信息'][scriptid]
	if o_saveinfo_data then
		o_saveinfo_data[key] = value
	else
		if GF.saveInfo then
			GF.saveInfo[key] = value
		else
			GF.errorLog('[GFSave]->Error,saveinfo is not init!',scriptid,debug.traceback())
		end
	end
end
------------------------------------------------存档信息 end------------------------------------

-- 获取本地平台信息BUFF
function GF.GetLocalGlobalInfo()
	local path = GF.GetPlayerInfoPath(global_name)
	return GF.LoadFile(path)
end

------------------------------------------------平台信息 start------------------------------------


local format_info
format_info = function(info,tabNum)
	local tp = type(info)
	if tp == 'table' then
		local string_tab = ""
		for i=1,tabNum-1 do
			string_tab = string_tab .. '\t'
		end
		local ans = {}
		local count = 1
		ans[count] = '{\n'
		count = count + 1
		for k,v in pairs(info) do
			ans[count] = string.format('%s\t[%s] = %s,\n',string_tab,format_info(k,tabNum+1),format_info(v,tabNum+1))
			count = count + 1
		end
		ans[count] = string_tab .. '}'
		return table.concat(ans,'')
	elseif tp == 'string' then
		return '"' .. info .. '"'
	else
		return tostring(info)
	end
end
local encodeGlobalInfo
encodeGlobalInfo = function(info)
	local out = {}
	local tp = type(info)
	if tp == 'table' then
		for k,v in pairs(info) do
			out[tostring(k)] = encodeGlobalInfo(v)
		end
	else
		return info
	end
	return out
end

local decodeGlobalInfo
decodeGlobalInfo = function(info)
	local tp = type(info)
	if tp == 'table' then
		local temp_info = {}
		for k,v in pairs(info) do
			temp_info[k] = v
		end
		for k,v in pairs(temp_info) do
			local key = tonumber(k)
			if key then
				info[key] = v
				info[k] = nil
			end
			decodeGlobalInfo(v)
		end
	end
end
-- 初始化平台信息
function GF.InitGlobalInfo(globalInfo)
	-- 注意：没连接上服务器时需要先使用本地的信息，给登录界面显示用
	if (globalInfo == nil or globalInfo == '') and SERVER_EVENT_SYNC == false then
		globalInfo = GF.GetLocalGlobalInfo()
	end
	if globalInfo and globalInfo ~= '' then
		-- perms = {
		-- 	[_ENV] = "_ENV",
		-- 	[GF] = 5,
		-- 	[xpcall] = 6,
		-- }

		global_save = js.decode(GF.unzip(globalInfo))--eris.unpersist(perms, globalInfo)
		decodeGlobalInfo(global_save)
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
			['千层塔到达最大层数']=0,
			['奇经八脉数据']={},
			['千层塔层到达记录']={},
			['物品产出限制']={},
		}
	end
	GF.log('初始化 glabolsaveinfo',global_save['难度系数'])
	GF.show_table(global_save['存档信息'])
end
-- 存储平台信息
function GF.GetSaveGlobalInfo()
	-- return 'local globalInfo = ' .. format_info(global_save,1) .. '\nreturn globalInfo'
	return GF.zip(js.encode(encodeGlobalInfo(global_save)))
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
	if global_save == nil then
		GF.errorLog('[平台信息]->global_save ERROR! no init')
		return
	end
	-- GF.call('添加提示',key, global_save[key])
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
	-- print('set global info ',key,value)
	-- if global_save[key] then
		global_save[key] = value
		GF.SaveGlobalInfo()
		return
	-- end
end

-- 对外接口,插入值
function GF.SetGlobalKeyValue(tname,key,value)
	if ( key == nil ) then
		return nil
	end
	if value == nil then value = true end
	if global_save[tname] == nil then global_save[tname] = {} end
	if type(global_save[tname]) == 'table' then
		global_save[tname][key] = value
		GF.SaveGlobalInfo()
	end
end

function GF.SaveLeaveOSSRecord()
	if GF.MISC == nil or GF.MISC.主角 == nil then
		return
	end
    print("SaveOSSRecord")

	local playerattrtable = {}
	local int_主角门派 = 0
	if GF.QueryName(0x10010001).门派 then
		int_主角门派 = GF.QueryName(0x10010001).门派.root
	end
	local int_主角等级 = GF.QueryName(0x10010001).等级 or 1
    local all_attr = GF.GetEnumValue('estrclass_roleattribute')
    for i=1,#all_attr do
        playerattrtable[all_attr[i]] = GF.call('角色_获取角色属性',GF.QueryName(GF.MISC.主角),all_attr[i])
    end
    playerattrtable["生命上限"] = GF.call('角色_获取角色属性最大值',GF.QueryName(GF.MISC.主角),'生命')
    playerattrtable["真气上限"] = GF.call('角色_获取角色属性最大值',GF.QueryName(GF.MISC.主角),'真气')
	local ossattrstr = js.encode(playerattrtable) or '{}'
	local int_千层塔到达最大层数 = GF.GetGlobalValue('千层塔到达最大层数') or 0
    local ossstr = str_form("%d,%d,%d,%s",int_主角等级,int_主角门派,int_千层塔到达最大层数,ossattrstr)
	GF.notify_server_event(NOTIFY_GAMER.RECORD_OSS_DATA, DHOSSLogType.DHOSS_PlayerAttr_Leave, ossstr)

    local playerownwuxuelist = GF.call('角色_获取武学列表',GF.QueryName(GF.MISC.主角)) or {}
    local wuxuetable = {}
    for k,v in pairs(playerownwuxuelist) do
        wuxuetable[tostring(v.root)] = GF.call('角色_武学等级',GF.QueryName(GF.MISC.主角),v)
    end
    ossattrstr = js.encode(wuxuetable)
    ossstr = str_form("%d,%d,%s",int_主角等级,int_主角门派,ossattrstr)
	GF.notify_server_event(NOTIFY_GAMER.RECORD_OSS_DATA, DHOSSLogType.DHOSS_PlayerWuXue_Leave, ossstr)

    if GF.IsTable(GF.cacheData.地图进入次数统计) then
        ossattrstr = js.encode(GF.cacheData.地图进入次数统计)
		GF.notify_server_event(NOTIFY_GAMER.RECORD_OSS_DATA, DHOSSLogType.DHOSS_Maze_IntoCount, ossattrstr)
    end

    local teamextralv,int_队友数 = GF.call('叠加等级_获取平台各队友叠加等级')
    local teamextralvstr = ""
    if int_队友数 and int_队友数 > 0 then
        ossattrstr = js.encode(teamextralv) or '{}'
        teamextralvstr = teamextralvstr
		GF.notify_server_event(NOTIFY_GAMER.RECORD_OSS_DATA, DHOSSLogType.DHOSS_PlayerTeam, teamextralvstr)
    end

    local o_misc_当日重铸 = GF.MISC.当日统计数据
    if GF.IsTable(o_misc_当日重铸) then
        local int_铜币重铸 = o_misc_当日重铸['铜币重铸'] or 0
        local int_精铁重铸 = o_misc_当日重铸['精铁重铸'] or 0
        local int_完美重铸 = o_misc_当日重铸['完美重铸'] or 0
        local int_蓝字次数 = o_misc_当日重铸['蓝字次数'] or 0
        if int_铜币重铸 ~= 0 or int_精铁重铸 ~= 0 or int_完美重铸 ~= 0 or int_蓝字次数 ~= 0 then
            ossstr = str_form("%d,%d,%d,%d",int_铜币重铸,int_精铁重铸,int_完美重铸,int_蓝字次数)
			GF.notify_server_event(NOTIFY_GAMER.RECORD_OSS_DATA, DHOSSLogType.DHOSS_PlayerAct_EquReMake, ossstr)
		end
    end

	local oss_npc = GF.call('OSS_角色交互_所有信息')
	if GF.IsTable(oss_npc) then
		ossstr = js.encode(oss_npc)
		GF.notify_server_event(NOTIFY_GAMER.RECORD_OSS_DATA, DHOSSLogType.DHOSS_PlayerAct_NPC, ossstr)
	end

	if GF.IsTable(GF.cacheData.oss_newbie_record) then
		local taskoss = {}
		for i = 1,#GF.cacheData.oss_newbie_record do
			taskoss[i] = ""..GF.cacheData.oss_newbie_record[i]['task_id'].."_"..GF.cacheData.oss_newbie_record[i]['stage_id'].."_"..GF.cacheData.oss_newbie_record[i]['node_index'].."_"..GF.cacheData.oss_newbie_record[i]['story_rec']
		end
		ossstr = js.encode(taskoss)
		GF.notify_server_event(NOTIFY_GAMER.RECORD_OSS_DATA, DHOSSLogType.DHOSS_PlayerNewBie, ossstr)
	end
end

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

---- 暂时留着
function GF.SetCanSave()

end
function GF.GetCurSaveIdx()
	return 1
end

function GF.GetCanSave()
	return false
end