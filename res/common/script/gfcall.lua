
local GF = require "gfbase"
local co = require "co"
local es = require 'gevent'
local js  = require "cjson.c"
local _d

GF.notify = {}
local api = {}
GF.api = api
GF.isP = true
GF.noti_call_count = 0
GF.isCollect=true
GF.o_meta = {
	__index = function(t,k)
		local v = rawget(t,GF.esc..tostring(k))
		if v then
			if type(v) == 'number' then
				v = GF.QueryName(v)
				rawset(t,k,v)
			else
				rawset(t,GF.esc..tostring(k),nil)
				v = GF.call(v)
				rawset(t,k,v)
			end
			if not GF.is_editor then
				rawset(t,GF.esc..tostring(k),nil)
			end
		end
		return v
	end,
	__newindex = function(t,k,v)
		if GF.strict_debug and not GF.isP then
			if k ~= 'skiptalk' and k ~= 'skipbattle' and k ~= "strict_debug" then
				error("Error! Attempt to modify data outside logic layer!" .. tostring(k) .. '  ' .. tostring(v))
				-- GF.errorLog("Error! Attempt to modify data outside logic layer!" .. tostring(k) .. '  ' .. tostring(v))
			end
		end
		rawset(t,k,v)
		if not GF.is_editor then
			rawset(t,'__'..tostring(k),nil)
		end
	end,
	__len = function(t)
		if t.n then return t.n + 1 end
		local i = 1
		while t[i] do
			i = i + 1
		end
		return i - 1
	end
}

GF.BLACK_NET_EVENT_LIST = {
    '等待下一帧',
    '任务等待下一帧',
}
function GF.editor_meta(value)
	if type(value) == 'table' then
		for k,v in pairs(value) do
			GF.meta(v)
		end
		local old_meta = getmetatable(value)
		if old_meta == nil then
			setmetatable(value, GF.o_meta)
		end
	end
end
function GF.meta(value)
	if GF.is_editor then
		return
	end
	if NEW_DATA_TEST_FZT then
		return
	end
	if type(value) == 'table' then
		for k,v in pairs(value) do
			GF.meta(v)
		end
		local old_meta = getmetatable(value)
		if old_meta == nil then
			setmetatable(value, GF.o_meta)
		end
	end
end

function GF.getFuncTips(farg_table)
	local func_name = farg_table[1]
	if GF.api[func_name] then
		local string_tips = c.GetFuncTips(func_name)
		return string_tips
	end
	return ""
end


local function noti_call(func,...)
	GF.noti_call_count = GF.noti_call_count + 1
	local f = GF.notify[func]
	local res
	if f then
		res = {f(...)}
	end
	GF.noti_call_count = GF.noti_call_count - 1
	if res ~= nil then
		return table.unpack(res)
	end
end

function GF.do_profile(funcName, funcNamePrefix, isCallOrRet)
	if GF.profileData then
		if type(funcName) ~= 'string' then
			return
		end
		funcName = '(' .. funcNamePrefix .. ')' .. ',' .. funcName
		local d = GF.profileData[funcName]
		if not d then
			d = {
				call_count = 0,
				call_time = 0,
				total_time = 0,
			}
			GF.profileData[funcName] = d
		end
		if isCallOrRet then
			-- call
			d.call_count = d.call_count + 1
			d.call_time = os.clock()
		else
			-- return
			if d.call_time > 0 then
				d.total_time = d.total_time + (os.clock() - d.call_time)
				d.call_time = 0
			end
		end
	end
end

GF.noti_call = noti_call
function GF.call(func,ex,...)
	local f
	if GF.IsTable(func) then
		local a = {}
		setmetatable(a, nil)
		for k,v in pairs(a) do
			a[k] = nil
		end
		for k,v in pairs(func) do
			a[k] = v
		end
		setmetatable(a, GF.o_meta)
		if type(a.n) == 'number' then
			for i = 1, a.n + 1 do
				-- a[i] = a[i]
				rawset(a,i,a[i])
				-- GF.log('call',a[i])
			end
		else
			for i = 1,#a do
				rawset(a,i,a[i])
				-- a[i] = a[i]
			end
		end
		if ex then
			local arg = {ex, ...}
			local index = 2
			for k,v in ipairs(arg) do
				table.insert(a,index,v)
				index = index + 1
			end
		end
		local ret = GF.call(table.unpack(a))
		-- GF.ReleaseTab(a)
		return ret
	elseif type(func) == 'function' then
		f = func
	else
		f = GF.api[func]
	end
	local r1
	if f ~= nil then
		local ismain = co.running()
		--GF.do_profile(func, 'p', true)
		if ismain then
			GF.set_readonly(true)
		end
		r1 = {f(ex, ...)}
		if ismain then
			GF.set_readonly(false)
		end
		--GF.do_profile(func, 'p', false)
		if GF.notify[func] == nil then
			return table.unpack(r1)
		end
	else
		if func ~= nil and GF.notify[func] == nil then
			if not GF.isServer() then 
				print('Warning: Cannot find call func ' .. tostring(func) .. '!!!')
			end
			-- GF.log('Warning: Cannot find call func ' .. tostring(func) .. '!!!', debug.traceback())
		end
	end
	--GF.do_profile(func, 'n', true)
	GF.set_readonly(true)
	noti_call(func, ex, ...)
	GF.set_readonly(false)
	--GF.do_profile(func, 'n', false)
	if r1 then
		return table.unpack(r1)
	else
		return r1
	end
end


local srED = es.newctx()
GF.srED = srED

function GF.srvEventData(ED)
	ED.uncase = ED.uncase or {}
	GF.srED = ED
	srED = ED
end
function GF.Clean_srED()
	srED = es.newctx()
	GF.srED = srED
end
local ev_info

local function init_ev_info()
	ev_info = {}
	for k,v in ipairs(require('o_event')[2]) do
		ev_info[v.name] = v
	end
end

table.insert(GF.update, function(t)
	if GF.isDreamland then 
		for i=1,#GF.MSG_QUEUE do
			local ev = GF.MSG_QUEUE[i]
			local ev_func_name = 'MSG_' .. ev[1]
			if GF.api[ev_func_name] then
				GF.call(ev_func_name,table.unpack(ev,2))
			end
		end
		GF.MSG_QUEUE = {}
	end
	if GF.isDreamland and SERVER_EVENT_SYNC then 
		if GF.isServer() then 
			print('--== update start')
		end
	end
	if GF.isDreamland and GF.needSave and GF.IsEventQueueEmpty() then 
		GF.call('杂项_存档')
		GF.needSave = false
	end
	if GF.NotifyNetEventClear then 
		GF.NotifyNetEventClear()
	end
	GF.isP = true
	GF.trig_event('等待下一帧')
	GF.trig_event('任务等待下一帧')
	es.tick(srED)
	GF.isP = false
	if GF.isDreamland and SERVER_EVENT_SYNC then 
		if GF.isServer() then 
			print('--== update end')
		end
	end
end)

function GF.get_event_def_data(event_name)
	if ev_info == nil then 
		init_ev_info()
	end
	return ev_info[event_name]
end

function GF.wait1(arg,...)
	local func = arg
	local earg
	if type(arg) == 'table' then -- new case
		func = arg[1]
	end
	local noti_func = es.parse_event(func)

	GF.case(0,arg,...)
	if type(arg) == 'table' then -- new case
		earg = arg
	else
		earg = {arg,...}
	end
	if noti_func == '角色交互' or noti_func == '选择角色' or noti_func == '选择场景' or noti_func == '新迷宫事件_点击任务事件卡片' then
		GF.call('wait_case_' .. noti_func,earg)
	end
	GF.set_readonly(true)
	noti_call(noti_func, earg)
	GF.set_readonly(false)

	if GF.isDreamland and SERVER_EVENT_SYNC then 
		print('--== wait1', noti_func)
	end
	local p = co.yield()
	if GF.isDreamland and SERVER_EVENT_SYNC then 
		print('--== continue wait1', noti_func)
	end
	local ev = p.e
	--es.remove_wait(srED, p)
	local endfunc = noti_func..'end'
	if GF.notify[endfunc] then
		if noti_func == '角色交互' or noti_func == '选择角色' or noti_func == '选择场景' or noti_func == '新迷宫事件_点击任务事件卡片' then
			GF.call('wait_case_end_' .. noti_func,earg)
		end
		noti_call(endfunc, earg)
	end
	srED.info = ev
end

function GF.wait_case()
	local arg = GF.get_case_event()

	for k = 1,#arg do
		if arg[k][1] == '角色交互' or arg[k][1] == '选择角色' or arg[k][1] == '选择场景' or arg[k][1] == '新迷宫事件_点击任务事件卡片' then
			GF.call('wait_case_' .. arg[k][1],arg[k])
		end
		noti_call(arg[k][1], arg[k])
	end
	if GF.isDreamland and SERVER_EVENT_SYNC then 
		print('--== wait_case')
	end
	local p = co.yield()
	if GF.isDreamland and SERVER_EVENT_SYNC then 
		print('--== continue wait_case')
	end

	-------- 用来判断是否有userdata在协程信息中
	if GF.strict_debug then
		local count = 1
		while true do
			local info = debug.getinfo(p.co,count)
			if info then
				local count2 = 1
				while true do
					local name,value = debug.getlocal(p.co,count,count2)
					if name and value then
						if type(value) == 'userdata' then
							error('userdata !!')
						end
					else
						break
					end
					count2 = count2 + 1
				end
			else
				break
			end
			count = count + 1
		end
	end

	local ev = p.e

	for k = 1,#arg do
		if arg[k][1] == '角色交互' or arg[k][1] == '选择角色' or arg[k][1] == '选择场景' or arg[k][1] == '新迷宫事件_点击任务事件卡片' then
			GF.call('wait_case_end_' .. arg[k][1],arg[k])
		end
		noti_call(arg[k][1]..'end', arg[k])
	end
	srED.info = ev
	--es.remove_wait(srED, p)
	return p.id
end

function GF.wait_case_pure()
	local arg = GF.get_case_event()

	local p = co.yield()
	local ev = p.e

	srED.info = ev
	return p.id
end

function GF.is_newgame()
	return #srED.wait <= 1
end


local function program_exit(ct)
	srED.uncase[ct] = nil
end
function GF.start_program(fname, ...)
	local func = api[fname]
	if func then
		local p = es.start_program(srED,fname, func, {...}, program_exit)
		-- GF.log('[GFCall]->StartProgram:',fname, p.co)
		return p
	end
end

function GF.remove_program(p, with_timer)
	if type(GF.update_data_event_list) == 'function' then
		GF.update_data_event_list(srED, p)
	end
	if with_timer then
		local timer = GF.__timer
		local rco
		if type(p) == 'string' then
			rco = es.get_co(srED, p)
		else
			rco = p.co
		end
		for k = #timer, 1, - 1 do
			if timer[k][2] == rco then
				table.remove(timer,k)
			end
		end
	end
	GF.log('remove_program',p)
	es.remove_wait(srED, p)
	local co_name
	local co_info
	if type(p) == 'string' then 
		co_name = p
		co_info = GF.get_co_by_name(co_name)
	else
		co_info = p.co
	end
	for k, v in pairs(srED.name) do
		if co_info and co_info == k then 
			srED.name[k] = nil
			return
		end
	end
end

function GF.get_co_by_name(co_name)
	for k = #srED.wait, 1, -1 do
		local pco = srED.wait[k].co
		if srED.name[pco] == co_name then 
			return pco
		end
    end
end

local function is_uncase(id)
	local rco = co.running()
	if srED.uncase[rco] then
		return srED.uncase[rco][id]
	end
end

function GF.case(id, ...)
	if is_uncase(id) then return end
	local p = {...}
	if GF.IsTable(p[1]) then -- new case
		if type(p[2]) == 'function' then
			p[1].cond = p[2]
		end
		if type(p[3]) == 'number' then
			p[1].prior = p[3]
		end
		if type(p[4]) == 'string' or type(p[4]) == 'nil' then
			p[1].group = p[4] or ""
		end
		if type(p[1][2]) == 'string' then
			p[1][2] = es.parse_string(p[1][2],GF)
		end
		p = p[1]
	else
		for k,v in pairs(p) do
			if type(v) == 'function' then
				p[k] = nil
				p.cond = v
				break
			end
		end
	end

	local event_suffix
	p[1], event_suffix = es.parse_event(p[1])

	p.id = id
	p.co = co.running()
	local didx = 2
	if id == 0 then
		didx = 3
	end
	local di = debug.getinfo(didx, 'fl')
	p._func = di.func
	p._cline = di.current
	p.suffix = event_suffix
	if ev_info == nil then
		init_ev_info()
	end
	local info = ev_info[p[1]]
	if info then
		-- p.stop = not info.nonstop
		if p.group == nil or p.group == "" then
			p.group = info.def_group
		end
		p.mono = info.mono
	end
	-- p.group = p.group or ''
	es.add_wait(srED, p)
	return p
end

function GF.uncase(id)
	local rco = co.running()
	srED.uncase[rco] = srED.uncase[rco] or setmetatable({}, co.weak_meta)
	srED.uncase[rco][id] = 1
end

function GF.clearuncase()
	local rco = co.running()
	local uncase = srED.uncase[rco]
	if uncase then
		for k,v in pairs(uncase) do
			uncase[k] = nil
		end
	end
end

function GF.event_stop(bstop)
	srED.stop = bstop
end


function GF.set_key_event(ev)
	if not srED.key_event then
		srED.key_event = {}
	end
	srED.key_event[ev] = {}
	srED.key_event[ev].group = ev_info[ev].def_group
end

function GF.unset_key_event(ev)
	if not srED.key_event then
		return
	end
	srED.key_event[ev] = nil
end

-- function GF.wait_level(prior)
-- end
function GF.setevent_info(info)
	srED.info = info
end
function GF.event_info()
	local info = srED.info
	if info then
		return table.unpack(info, 2, info._sz)
	end
end
function GF.event_info_length()
	local info = srED.info
	if info then
		return info._sz
	end
	return 0
end
function GF.event_name()
	local info = srED.info
	if info then
		return srED.info[1] or ""
	end
end

_G.remote_event = function(buf)
	local js  = require "cjson.c"
	local arg = js.decode(buf)
	GF.trig_event(table.unpack(arg))
end

function GF.rpt_event(proj, ...)
	local js  = require "cjson.c"
	local buf = js.encode({...})
	GF.RSCall(proj,'remote_event',buf)
end

function GF.addListener(fname,earg, cond, prior, group)
	local event = earg
	if GF.IsTable(earg) == false then
		earg = {event}
	end
	earg.cond = cond
	earg.prior = prior
	earg.group = group
	local func = api[fname]
	if func == nil then return end
	es.add_callback(srED, func, earg)
end

function GF.removeListener(fname,ev_name)
	local func = api[fname]
	if func == nil then return end
	es.remove_callback(srED, func, ev_name)
end

function GF.get_listering(ev_name)
	return srED.wait[ev_name]
end

function GF.find_event(...)
	local arg = {...}
	local same
	for _,v in ipairs(srED.event) do
		same = true
		for k = 1,#arg do
			if arg[k] ~= v[k] then
				same = false
				break
			end
		end
		if same then
			return true
		end
	end
end

function GF.get_case_event()
	local cc = co.running()
	local lst = {}
	local idtab = {}
	srED.wait.__mono_wait = srED.mono_wait
	for _,wait in pairs(srED.wait) do
		for k = #wait, 1, -1 do
			local p = wait[k]
			if p.co == cc then
				if not GF.ContainData(lst,p) then
					table.insert(lst, p)
					idtab[p] = p.id or 1
				end
			end
		end
	end
	table.sort(lst,function(a,b)
		return idtab[a] < idtab[b]
	end)
	srED.wait.__mono_wait = nil
	return lst
end

function GF.get_curcase(event_name, lst)
	local cc = co.running()
	local ev_wait = srED.wait[event_name]
	for _,wait in ipairs({srED.mono_wait, ev_wait}) do
		--for k = #wait, 1, -1 do
		for k = 1, #wait do
			local p = wait[k]
			if p.co == cc and p[1] == event_name and (not p.cond or p.cond()) then
				if lst then
					table.insert(lst, p)
				else
					return p
				end
			end
		end
	end
	return lst
end

function GF.get_case(event_name, lst)
	local ev_wait = srED.wait[event_name]
	for _,wait in ipairs({srED.mono_wait, ev_wait}) do
		--for k = #wait, 1, -1 do
		for k = 1, #wait do
			local p = wait[k]
			if p[1] == event_name then
				if lst then
					table.insert(lst, p)
				else
					return p
				end
			end
		end
	end
	return lst
end

-- 获取对话类的 debug 信息
-- @return(string)  函数名
-- @return(int)  当前行数
function GF.get_dialogue_debug_info()
	local d_funs
	local d_line
	local index = 1
	local debug_info
	local last_debug_info = nil
	-- 获取剧情名
	local cur_co = co.running()
	if cur_co and GF.srED.name[cur_co] then
		d_funs = GF.srED.name[cur_co]
	end
	debug_info = debug.getinfo(index)
	index = index + 1
	while debug_info do
		last_debug_info = debug_info
		debug_info = debug.getinfo(index)
		index = index + 1
		if debug_info and string.find(debug_info['short_src'], '[C]')  then
			d_line = last_debug_info['currentline'] - last_debug_info['linedefined']
		end
	end
	return d_funs,d_line
end

-- 获取当前等待的 case 总数
-- @return  返回 case 的数量
function GF.get_case_count()
	local cc = co.running()
    local case_count = 0
	srED.wait.__mono_wait = srED.mono_wait
    for _,wait in pairs(srED.wait) do
        for k = #wait, 1, -1 do
            local p = wait[k]
			if p.co == cc then
            	case_count = case_count + 1
            end
        end
    end
    srED.wait.__mono_wait = nil
    return case_count
end

local trig_count = 0
local lastGCTime = 0
local boolean_needGC = false
GF.MSG_QUEUE = {}
function GF.trig_event(...)
	local run, main_thread = co.running()
	local ev = {...}

	if ev_info == nil then
		init_ev_info()
	end
	if type(GF.trig_event_dreamland) == 'function' then
		GF.trig_event_dreamland(ev, main_thread)
	end

	if srED.key_event and ev_info[ev[1]] then
		for k, v in pairs(srED.key_event) do
			if v.group == ev_info[ev[1]].def_group and ev[1] ~= k then
				return
			end
		end
	end
	srED.info = {...}
	es.trig_event(srED, not main_thread, ...)
	
	if main_thread and ev[1] ~= '等待下一帧' and ev[1] ~= '任务等待下一帧' then -- 主协程
		trig_count = trig_count + 1
		table.insert(GF.MSG_QUEUE,ev)
	end
	if trig_count > 30 then
		boolean_needGC = true
	end
	if os.clock() - lastGCTime > 60 then -- 3分钟没有gc就gc一次
		boolean_needGC = true
	end
	if boolean_needGC then
		trig_count = 0
		boolean_needGC = false
		lastGCTime = os.clock()
		collectgarbage("collect")
		print('gc time:', os.clock() - lastGCTime)
	end
	ev = nil
end

function GF.SerializeEvent(...)
	local ev = {...}
	local tlist = {}
	for i=1,#ev do
		if ev[i] and GF.IsTable(ev[i]) and ev[i].name and ev[i].root then
			tlist[i] = ev[i].name
		else
			tlist[i] = ev[i]
		end
	end

	return tlist
end

function GF.remove_all_program()
	local pname = {}
	for k, v in pairs(srED.name) do
		table.insert(pname, v)
	end
	for i = 1, #pname do
		es.remove_wait(srED, pname[i])
	end
end

-- 获取所有协程信息
function GF.get_all_programinfo()
	local coroutineinfo = {}
	for k, v in pairs(srED.name) do
		table.insert(coroutineinfo, {name = v})
	end

	return coroutineinfo
end

-- 判断一个协程是否存在
-- @params(string)  name: 协程的名称
-- @return(boolean)  返回是否存在
function GF.program_alive(name)
	for _,wait in pairs(srED.wait) do
		for k = #wait, 1, -1 do
			if srED.name[wait[k].co] == name then
				return true
			end
		end
	end
	return false
end

-- 判断一个协程是否存在
-- @params(string)  name: 协程的名称
-- @return(boolean)  返回是否存在
function GF.co_alive(coroutineinfo)
	if co.status(coroutineinfo) == 'dead' then 
		return false
	end
	for k, v in pairs(srED.name) do
		if k == coroutineinfo then
			return true
		end
	end
	return false
end

-- 获取一个协程的数量
-- @params(string)  name: 协程的名称
-- @return(int)  返回协程的数量
function GF.GetProgramCount(name)
	local count
	count = 0
	for k, v in pairs(srED.name) do
		if v == name then
			count = count + 1
		end
	end
	return count
end

-- 清空事件队列
-- @params(table)  ED: 事件系统数据
function GF.ClearEventQueue()
    es.clear_event_queue(srED)
end

-- 输出所有协程信息
function GF.LogEventInfo(dont_show_detail)
	GF.log('[gfcall]->LogEventInfo')
	GF.logtable(srED, dont_show_detail)
end

function GF.IsEventQueueEmpty()
	local head_index

	if not (type(srED.event) == 'table' and #srED.event > 0) then
		return true
	end

	if srED.lock_event_queue_idx and srED.lock_event_queue_idx > 0 then
		head_index = srED.lock_event_queue_idx + 1
	else
		head_index = 1
	end
	for i = head_index, #srED.event do
		local is_system_event = false
		for j = 1, #GF.BLACK_NET_EVENT_LIST do
			if srED.event[i][1] == GF.BLACK_NET_EVENT_LIST[j] then
				is_system_event = true
			end
		end
		if not is_system_event then
			return false
		end
	end

	return true
end

function GF.IsStartProgramQueueEmpty()
	local head_index

	if not (type(srED.pending_start) == 'table' and #srED.pending_start > 0) then
		return true
	end

	if #srED.pending_start <= srED.lock_pending_start_idx then 
		return true
	end

	return false
end

function GF.IsMonoWaitEmpty()
	if type(srED.mono_wait) == 'table' and #srED.mono_wait > 0 then
		return false
	end
	return true
end

function GF.GetMonoWaitCount()
	if type(srED.mono_wait) == 'table' then
		return #srED.mono_wait
	end
	return 0
end

function GF.GetMonoWait()
	return srED.mono_wait
end

function GF.ResetMonoWait()
	srED.mono_wait = {}
end

function GF.SetMonoWait(mono_wait)
	srED.mono_wait = mono_wait
end

function GF.LockEventAndProgramQueue()
	es.LockEventAndProgramQueue(srED)
end

function GF.UnlockEventAndProgramQueue()
	es.UnlockEventAndProgramQueue(srED)
end

function GF.IsNotiCall()
	return GF.noti_call_count > 0
end

function GF.set_readonly(boolean_open)
end

function GF.get_readonly()
end

function GF.reset_net_event_count()
end

function GF.IsEventInQueue(event_name)
	return es.IsEventInQueue(srED, event_name)
end

function GF.IsEventWaitExist(event_name)
	return es.IsEventWaitExist(srED, event_name)
end

function GF.IsEventAndProgramQueueLocked()
	return es.IsEventAndProgramQueueLocked(srED)
end
