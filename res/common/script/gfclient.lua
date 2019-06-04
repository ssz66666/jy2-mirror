local c = require 'gcore.c'
local GF = require "gfbase"
local SF = require('sf')
local ws = require "websocket.c"
local js  = require "cjson.c"
local core = require "sproto.core"
local crypt = require "crypt.c"
local client
local session = 0
local cache = {}
---------------------------------------------
local isconnect
local newclient
local gate_url
local secret
local reconnect_args = {}
local index = 0
local net_interrupt_start = 0  --若网络中断开始时间
local net_interrupt_offset = 0  --若网络中断间隔时间
local net_close_time = 10  --若网络中断, 重试多少秒后返回登陆界面
local net_heart_beat_time = 0

local Obj2ID = function(ev)
	if cache[ev] then
		ev = cache[ev]
		return
	end
	cache[ev] = ev
	for k,v in pairs(ev) do
		if type(v) == 'table' then
			if cache[v] then
				ev[k] = cache[v]
			else
				local name = v.name
				local root = v.root
				if name and tonumber(name) and GF.QueryName(tonumber(name)) then
					cache[v] = { i_d = name, r_t = root}
					ev[k] = { i_d = name }
				elseif root and tonumber(root) and GF.QueryName(tonumber(root)) then
					cache[v] = { i_d = root}
					ev[k] = { i_d = root }
				else
					Obj2ID(v)
				end
			end
		else

		end
	end
end

function GF.netprocess(msg)
	print('gfclient.netprocess,it should not being called,because game should implement it')
end

local receive_fun
local function set_recevie(fun)
	receive_fun = fun
end

local ws_callback_old = function(msg)
	-- print("ws_callback_old ws_callback_old ws_callback_old")
	receive_fun(msg)
end

local ws_callback_new = function(msg)
	if msg then
		if isconnect then
			GF.netprocess(crypt.desdecode(secret, msg))
		else
			if msg == "200 OK" then
				isconnect = true
				if reconnect_args.reconnect then
					GF.netMessage('reconnect')
					GF.setCancelReconnect()
				else
					GF.set_serverid(gate_url)
					print("set_serverid", gate_url)
					GF.netMessage('get_player_status')
				end

			else
				GF.log("[ERROR] connect error")
				GF.net_close()
			end
		end
	else
		print("------------ msg is nil, in town: "..tostring(_G.CONNECT_IN_TOWN))
		GF.setReconnectState()
	end
end

--初始化连接状态
local function init_connect_state(is_reconnect)
	client = nil
	newclient = nil
	isconnect = false
	if not is_reconnect then
		reconnect_args = {}
		GF.set_serverid()
	end
end

--设置开始断线重连
function GF.setReconnectState()
	--在城镇中才触发断线重连机制
	if _G.CONNECT_IN_TOWN then
		reconnect_args.reconnect = true
		net_interrupt_start = os.time()
		net_interrupt_offset = net_interrupt_start
		--显示加载转菊花
		local common层 = GF.getUI('v_common')
		if common层 then
			local script = common层.c_common
			script:询问断线重连(false)
			script:显示加载中(true)
		end
	end
end

--设置取消重连状态
function GF.setCancelReconnect()
	reconnect_args.reconnect = nil
	--隐藏加载转菊花
	local common层 = GF.getUI('v_common')
	if common层 then common层.c_common:显示加载中(false) end
end

-- 发送心跳包
function GF.checkSendHeartBeat()
	--心跳包一定需要连入城镇了之后才发送,并且不能处于短线重连期间,间隔10s
	if _G.CONNECT_IN_TOWN and not reconnect_args.reconnect then
		if ( net_heart_beat_time == 0 ) then
			net_heart_beat_time = os.time()
		end
		if( (os.time() - net_heart_beat_time) > _G.CLIENT_SERVER_HEARTBEAT_TIME ) then
			net_heart_beat_time = os.time()
			GF.netMessage('heartbeat')
		end
	end
end

table.insert(GF.update, function(dt)

	if client then
		ws.update(client,ws_callback_old)
	end

	if newclient then
		ws.update(newclient,ws_callback_new)
	end

	-- 断线重连检测
	if reconnect_args.reconnect then
		if os.time() - net_interrupt_start > net_close_time then
			--GF.coon_timeout_close()
			reconnect_args.reconnect = nil
			local common层 = GF.getUI('v_common')
			if common层 then
				local script = common层.c_common
				script:显示加载中(false)
				script:询问断线重连(true)
			end
		elseif os.time() - net_interrupt_offset >= 1 then
			print('reconnecting...'..(net_interrupt_offset - net_interrupt_start + 1))
			GF.reconnect()
			net_interrupt_offset = os.time()
		end
	end

	-- 心跳包发送
	if newclient then
		GF.checkSendHeartBeat()
	end
end)

function GF.coon_timeout_close()
	print("reconnect time out, back to login opration")
	GF.SetCanSave(false)
	GF.call('系统_退出战斗速度还原')
	-- GF.call('剧本_退出剧本', false)
	GF.net_close()
end

local function conn_gate(ser_name, subid, player_id, proto)
	index = index + 1
	print("ready connect url:", gate_url, " proto",proto)
	newclient = ws.open(gate_url, proto,"")
	if newclient then
		GF.player_id = GF.toint(player_id)
		local handshake = string.format("%s@%s#%s:%d", crypt.base64encode(tostring(player_id)), ser_name,subid , index)
		local hmac = crypt.hmac64(crypt.hashkey(handshake), secret)
		local package = handshake .. ":" .. crypt.base64encode(hmac)
		-- package = string.pack(">s2", package)
		ws.send(newclient, package)
		reconnect_args.ser_name = ser_name
		reconnect_args.subid = subid
		reconnect_args.index = index
	end
end

function GF.net_open(url, proto, ac_info)
	local auth_msg = {}
	local challenge
	local clientkey
	local hmac

	local token = {}
	--连接服务器之前先清理数据 否则若登录过程中失败 服务器消息的入口会错误
	init_connect_state()
	print("ready connect url:", url, " proto:", proto)
	-- url = "ws://59.110.172.173:5012"
	client = ws.open(url, proto,"") --'ws://192.168.110.231:8080','mjh-protocol',''
	print("ready connect over client:", client)
	ws.send(client, "auth")
	set_recevie(function(mg)
		if not mg then
			print("server close fd")
			GF.log("[ERROR] connect error")
			return
		end
		local len = #auth_msg + 1
		if mg == nil or mg == "408" then
			print("server wait request timeout")
			-- GF.call('添加提示',"连接超时")
			GF.net_close()
			return
		end
		auth_msg[len] = mg
		if len == 1 then
			local ok
			ok, challenge = pcall(crypt.base64decode, mg)
			if not ok then
				GF.log("[ERROR] base64decode error", mg)
				error("base64decode error")
			end
			clientkey = crypt.randomkey()
			local tmp = crypt.base64encode(crypt.dhexchange(clientkey))
			print("start send clientkey time", os.clock())
			ws.send(client, tmp)
		elseif len == 2 then
			secret = crypt.dhsecret(crypt.base64decode(mg), clientkey)
			print("challenge", crypt.hexencode(challenge), " secret", crypt.hexencode(secret))
			hmac = crypt.hmac64(challenge, secret)
			print("hmac:", crypt.hexencode(hmac))
			ws.send(client, crypt.base64encode(hmac))
		elseif len == 3 then
			token.login_type = ac_info.login_type
			token.open_id = ac_info.open_id
			token.access_token = ac_info.access_token
			local function encode_token(token)
				return string.format("%s@%s:%s",
					crypt.base64encode(token.login_type),
					crypt.base64encode(token.open_id),
					crypt.base64encode(token.access_token))
			end

			local etoken = crypt.desencode(secret, encode_token(token))
			print("----------------  send token ", crypt.base64encode(etoken), secret)
			GF.tabPrint(token)
			ws.send(client, crypt.base64encode(etoken))
		elseif len == 4 then
			local code = string.sub(mg, 1,3)

			code = tonumber(code)
			if code == 200 then
				local addr, ser_name, subid, player_id = string.match(string.sub(mg,5), "([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*)")
				client = nil
				gate_url = "ws://"..crypt.base64decode(addr)
				conn_gate(ser_name, subid, crypt.base64decode(player_id), proto)
			else
				local info
				if code == 406 then
					info = "账号不存在"
				elseif code == 407 then
					info = "密码错误"
				elseif code == 403 then
					info = '账号锁定中'
				elseif code == 510 then
					info = '系统维护中'
				elseif code == 500 then
					info = '系统繁忙'
				else
					info = string.sub(mg, 5)
				end
				print("login faild!", code, info)

				GF.call('添加提示框',info,{
					[1]={'确定',function()
						GF.net_close()
					end}
				})
			end
		end
	end)
end

function GF.reconnect()
	init_connect_state(true)
	--print("---------------  try reconnect")
	-- reconnect_args.reconnect = true
	conn_gate(reconnect_args.ser_name, reconnect_args.subid, GF.player_id, "")
end

function GF.net_close(url, proto)
	if GF.GetOS() ~= 1 then 
		local string_存放目录 = string.gsub(GF.WritePath(''), "\\", "/")
		string_存放目录 = string.gsub(string_存放目录,'dreamland','loader') .. 'dreamland'
		GF.Restart('dreamland', string_存放目录)
	else
		GF.Restart('project/dreamland') -- 直接重启，简单粗暴
	end
	-- init_connect_state()
	-- -- GF.changeUI('v_common')
	-- --据说直接changeUI会使一些提示出不来
	-- --所以这里就修改一下,直接移除不是common的ui, 保留common层
	-- local ui_common = nil
	-- for int_i = 1, c.Stage().childCount do
	-- 	local ui = c.Stage().getChildAt(0)
	-- 	if ui and (ui.name ~= 'v_common') then
	-- 		GF.removeUI(ui)
	-- 	else
	-- 		ui_common = ui
	-- 	end
	-- end
	-- --如果common层的剧情组件是开启状态, 则关闭
	-- if ui_common then
	-- 	local script = ui_common.c_common
	-- 	script:询问断线重连(false)
	-- 	script.剧情.visible = false
	-- end
	-- GF.addUI('v_login')
	-- GF.setCancelReconnect()
end

function GF.on_recv(ev)

end

function GF.net_send(proto, msg)
	if (proto == nil) then
		return
	end
	local pid
	if type(proto) == "number" then
		pid = proto
	else
		pid = proto.id
	end
	if newclient and isconnect then
		session = session + 1
		local registerReq = {
				header = {
					protoid = pid,
					session = session,
					response = 0,
				},
				data = msg,
		}
		local packmsg = GF.net_msg_pack(registerReq)
		if packmsg then
			ws.sendbinary(newclient, crypt.desencode(secret, packmsg))
		else
			print("send msg failed")
		end
	end
end

-- 通知服务端删除存档
-- @params(int)  idx: 存档编号
function GF.req_save_delete(idx)
	-- 调用服务端 on_req_save_delete
	-- ...
end

-- 服务器将新存档的随机种子和 id 传回来以供客户端新建存档
function GF.noti_newsave(buf)
	local save_id
	local random_seed
	-- 获取随机种子和 id
	-- ...
    G.trig_event("save_new", save_id, random_seed)
end

function GF.GetOS()
	return c.GetOS()
end

function GF.isServer()
	return false
end

function GF.notify_server_event(notify_msg, ...)
	-- 服务端的消息自驱动，客户端实现留空
	if notify_msg == nil then
		return
	end

	local arg = {...}
	if notify_msg.id == 0x0344 then -- OSS上报
		local logtype = arg[1]
		local ossmsg = arg[2]
		GF.netMessage('syncOSSRecord',logtype,ossmsg)
	else
		print('notify_server_event', notify_msg.func, ...)
	end	
end
