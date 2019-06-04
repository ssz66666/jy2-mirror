print(">>>> Start network.lua >>>>")
local c = require("gcore.c")

--local proto = require "proto"
--local sproto = require "sproto"
local GF = require "gf"
local sock = require "socket"
local co = require "co"
local tcp = nil

--local host = sproto.new(proto.s2c):host "package"
--local request = host:attach(sproto.new(proto.c2s))


local SOCKET_TICK_TIME = 200 				-- check socket data interval
local SOCKET_RECONNECT_TIME = 500000			-- socket reconnect try interval --[CY MOD: debug, default is 5000]
local SOCKET_CONNECT_FAIL_TIMEOUT = 15000	-- socket failure timeout  --[CY MOD:debug, default is 3000]

local STATUS_CLOSED = "closed"
local STATUS_NOT_CONNECTED = "Socket is not connected"
local STATUS_ALREADY_CONNECTED = "already connected"
local STATUS_ALREADY_IN_PROGRESS = "Operation already in progress"
local STATUS_TIMEOUT = "timeout"



local net = {}
local states = {}
local game_st

local function new_state(ip, port)
	local st = {}
	st.ip = ip
	st.port = port
	st.state = 0 --off
	st.last = ""
	st.session = 0
	st.cb = {}
	return st
end

function net.send(id, args, respCB)
	net._send(game_st, id, args,respCB)
end

function net._send(st, id, args, respCB)
	st.session = st.session + 1
	if respCB then
		st.cb[st.session] = respCB
	end
	GF.logMsg(st.session.."_req_"..id,args)
	net.sendpackage(st, request(id,args,st.session),st.session)
end

function net.sendpackage(st, pack, session)
	local buf = c.Pack(pack, session)
	local sz ,err ,sentsz = st.tcp:send(buf)
	if err then print(err, sz, sentsz) end
end

function net.sendline(st, line)
	local sz ,err ,sentsz = st.tcp:send(line..'\n')
	if err then print(err, sz, sentsz) end
end

function net.recv(gst, m)
	print("on_data")
	local t,n_or_s,args = host:dispatch(m)
	if t == "REQUEST" then
		if n_or_s == "cproto" then
			c.recv(args.type,args.info)
		end
	else
		local f = gst.cb[n_or_s]
		gst.cb[n_or_s] = nil
		GF.logMsg(n_or_s.."_rev",args)
		if f then f(args) end
	end
end

local function c_send(tp,buf)
	session = session + 1
	args = {["type"]= tp,["info"] = buf}
	c.send(request("cproto",args,session))
end


local function closed(st)
	st.last = ""
	st.tcp:close()
	st.state = 0
end

local function connected(st)
	print("connected!!!")
	st.state = 2
	local function tick_net()
		while true do
			if st.state ~= 2 then -- not connected
				break
			end
			co.wait_time(SOCKET_TICK_TIME)
			while true do

				-- if use "*l" pattern, some buffer will be discarded, why?
				local __body, __status, __partial = st.tcp:receive("*a")	-- read the package body
				--print("body:", __body, "__status:", __status, "__partial:", __partial)
				if __status == STATUS_CLOSED or __status == STATUS_NOT_CONNECTED then
					closed(st)
					break
				end
				if (__body and string.len(__body) == 0) or (__partial and string.len(__partial) == 0) then break end
				if __body and __partial then __body = __body .. __partial end
				st.last = st.last..(__body or __partial)
				
				while true do
					local result
					result, st.last = st.unpack(st.last)
					if not result then
						break
					end
					st:recv(result)
				end
				
			end
		end
	end
	local ct = co.create(tick_net)
	co.resume(ct)
end

local function reconnect(st)
end

function net.connect(ip, port, cb)
	local key = ip..':'..port
	local st = states[key]
	if st then 
		reconnect(st)
	else
		st = new_state(ip, port)
		states[key] = st
	end
	st.tcp = sock.tcp()
	
	local wait
	local function check()
		local ret, stat = st.tcp:connect(ip, port)		
		local ok =  ret == 1 or stat == STATUS_ALREADY_CONNECTED
		if ok then
			connected(st)
			if cb then cb() end
		end
		return ok
	end
	st.tcp:settimeout(0)
	function connect()
		while true do
			if check() then break end
			wait = wait or 0
			wait = wait + SOCKET_TICK_TIME;
			if wait >= SOCKET_CONNECT_FAIL_TIMEOUT then
				wait = nil
				closed(st)
				print("connect failed !!!!")
			end
			co.wait_time(SOCKET_TICK_TIME)
		end
	end
	st.state = 1 -- connecting
	local ct = co.create(connect)
	co.resume(ct)
	return st
end

function net.close(st)
	closed(st)
end

function net.default(st)
	game_st = st
end

function net.unpack_line(text)
	local from = text:find("\n", 1, true)
	if from then
		return text:sub(1, from-1), text:sub(from+1)
	end
	return nil, text
end

function net.unpack_package(text)
	local size = #text
	if size < 2 then
		return nil, text
	end
	local s = text:byte(1) * 256 + text:byte(2)
	if size < s+2 then
		return nil, text
	end

	return text:sub(3,2+s), text:sub(3+s)
end

return net