
local GF = require "gfbase"
-- 初始随机种子
GF.init_random_seed = nil

function GF.split(str, sep)
    local fields = {}
    local pattern = string.format('([^%s]+)', sep)
    string.gsub(str, pattern, function(c)
        table.insert(fields, c)
    end)
    return fields
end

function GF.clamp(value,min,max)
	return math.max(math.min(value,max),min)
end

function GF.sum(array)
	if array == nil or type(array) ~= 'table' then
		return 0
	end
	local result = 0
	for _,v in pairs(array) do
		result = result + v
	end
	return result
end

function GF.foreach(array,func)
	if array then
		for _,data in pairs(array) do
			func(data)
		end
	end
end

function GF.any(array,func)
	if array then
		for _,data in pairs(array) do
			local ans = func(data)
			if ans then
				return ans
			end
		end
	end
	return nil
end

function GF.Random(min, max, is_logic_random)
	local co = require "co"
	local run, main_thread = co.running()

	if max == nil then
		if min == nil then
			return -1
		else
			max = min
			min = 1
		end
	end
	if not (min and max) then
		return -1
	end
	min = math.floor(min)
	max = math.floor(max)
	if min > max then
		min = min + max
		max = min - max
		min = min - max
	end

	return GF.random(min, max)
end

function GF.DisableRandomManager()
	GF.random_manager_state = 'disabled'
end

function GF.EnableRandomManager()
	GF.random_manager_state = 'enabled'
end

function GF.get_obj_type(obj_id)
	local type_id
	type_id = (obj_id&0xF0000000)>>28
	if type_id == 0x2 then
		return "mcf"
	elseif type_id == 0x3 then
		return "swf"
	elseif type_id == 0x5 then
		return "png"
	elseif type_id == 0xd then
		return "lua"
	else
		return "undefined"
	end
end

function GF.clean_num(int_s,int_f,boolean_end)
	if int_s == nil then return 0 end
	if math.ceil(int_s-0.00000001) < int_s then
        return math.floor(int_s)
    end
    if math.floor(int_s+0.00000001) > int_s then
        return math.ceil(int_s)
	end
	if math.floor(int_s)==math.ceil(int_s) then
        return math.ceil(int_s)
	end
	int_f = int_f or 0
	if int_f and not boolean_end then
		local ret
		local sf = '%.' .. int_f .. 'f'
		ret =  string.format(sf,int_s)
		if ret then
			return GF.clean_num(tonumber(ret),nil,true)
		end
	end
    return int_s
end

function GF.misc()
	return GF.QueryIndex("o_misc",1)
end

function GF.get_sys_random_state()
	local random_state
	random_state = {}
	random_state[1], random_state[2], random_state[3], random_state[4] = GF.rawget_randomseed()
	return random_state
end

function GF.set_sys_random_state(random_state)
	if type(random_state) == 'table' and #random_state == 4 then
		GF.rawset_randomseed(random_state[1], random_state[2], random_state[3], random_state[4])
	end
end

-- 设置客户端层连接的服务器地址
function GF.set_serverid(string_serverID)
	GF.服务器地址 = string_serverID
end

-- 判断当前是否处于联机状态
function GF.get_isconnect()
	if GF.isServer() then
		return true
	end
	return GF.服务器地址 ~= nil
end

-- 判断当前位置,0:城镇中,1:剧本中
function GF.get_clientstate()
	return GF.cacheGlobalData.clientstate
end

-- 设置当前位置,0:城镇中,1:剧本中
function GF.set_clientstate(int_state)
	GF.cacheGlobalData.clientstate = int_state
end

-- 初始化随机种子
function GF.get_new_random_seed()
	local random_seed = tostring(os.time()):reverse():sub(1, 6)
	random_seed = tonumber(random_seed)
	return random_seed
end

-- 设置随机种子
function GF.set_random_seed(int_randomseed)
	if not int_randomseed then
		if GF.init_random_seed ~= nil then
			int_randomseed = GF.init_random_seed
		else
			int_randomseed = GF.get_new_random_seed()
			GF.init_random_seed = int_randomseed
		end
	end
	GF.randomseed(int_randomseed)
end

-- 设置客户端层连接的服务器地址
function GF.set_autologin_info(autologin_info)
	GF.cacheGlobalData.autologin_info = autologin_info
end

-- 获取服务器地址
function GF.get_autologin_info()
	return GF.cacheGlobalData.autologin_info
end

function GF.getMD5(string_info)
	local md5 = GF.GetMD5(string_info)
	local md5_32 = ""
	for i=1,#md5 do
		local a = string.byte(md5,i)
		local fix = (a & 0xf0) >> 4
		local pos = (a & 0x0f)
		md5_32 = md5_32 .. string.format('%x%x',fix,pos)
	end
	return md5_32
end

function GF.clamp_0_1(number_value)
	return mmin(mmax(number_value,0),1)
end

