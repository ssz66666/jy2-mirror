local co = require 'co'
local t = {}
local can_log_detail = false

function t.newctx()
    local ctx = {
        event = {},
        wait = {},
        name = setmetatable({}, co.weak_meta),
        callback = {},
        co_pool = setmetatable({}, co.weak_meta),
        -- keep context wait
        mono_run = nil,
        mono_wait = {},
        pending_start = {},
        pending_running = {},
        uncase = {},
        lock_event_queue_idx = -1,
        lock_pending_running_idx = -1,
        lock_pending_start_idx = -1,
        lock_count = 0,
    }
    return ctx
end

local function resume_wait(ED,p)
    local ret,tag
    ED.info = p.e
    for k = 1, #ED.mono_wait do
        ED.mono_wait[k] = nil
    end
    t.remove_wait(ED, p)
    -- print('进入线程',ED.name[p.co])
    local G = require 'gf'
    if p.isAction ~= true then
        G.set_readonly(false)
    end
    if p.arg then -- ?
        ret,tag = co.resume(p.co, table.unpack(p.arg))
    else
        ret,tag = co.resume(p.co, p)
    end
    if p.isAction ~= true then
        G.set_readonly(true)
    end
    -- print('离开线程',ED.name[p.co])

    if tag == 'EXIT' then
        ED.name[p.co] = nil
    end
end

local g_s_sub = string.sub
local g_s_find = string.find
local g_type = type
local g_t_remove = table.remove
local g_t_insert = table.insert
local function match_arg(pa, ea)
    if pa == ea then return true end
    local tpa = g_type(pa)
    local tea = g_type(ea)
    if tpa ~= tea then return false end
    if (tpa == 'table' or tpa == 'userdata') and g_type(pa.name) == 'number' and g_type(ea.name) == 'number' then
        if pa.name == pa.root then
            return ea.root == pa.root
        else
            return ea.name == pa.name
        end
    elseif tpa == 'string' then
        if g_s_sub(pa, 1, 1) == '[' and g_s_sub(pa, 4, 4) == ']' then
            pa = g_s_sub(pa, 5)
        end
        if g_s_sub(ea, 1, 1) == '[' and g_s_sub(ea, 4, 4) == ']' then
            ea = g_s_sub(ea, 5)
        end
    end
    return pa == ea
end
local function match_event(p, e)
    if not e._sz then
        local sz = 0
        for k,v in pairs(e) do
            if g_type(k) == 'number' and k > sz then
                sz = k
            end
        end
        e._sz = sz
    end
    for idx = 1, e._sz do
        if p[idx] ~= nil and e[idx] ~= nil and not match_arg(p[idx], e[idx]) then
            if idx == 1 then
                local tmp_p = t.parse_event(p[1])
                if tmp_p ~= e[1] then
                    return false
                end
            else
                return false
            end
        end
    end
    local GF = require 'gf'
    GF.setevent_info(e)
    if g_type(p.cond) == 'function' and not p.cond(table.unpack(e, 2, 100)) then
        return false
    end
    return true
end

local function cmp_event(a,b)
    if a.prior == b.prior then
        return a._idx > b._idx
    end
    return a.prior > b.prior
end

local function collect_match(checks, e, out)
    local group = {}
    local i_out_count = #out
    --for k = 1, #checks do
    for k = #checks,1,-1 do
        local v = checks[k]
        if match_event(v,e) then
            v.prior = v.prior or 0
            local insert = true
            if v.group then
                local cur = group[v.group]
                if cur == nil or v.prior > cur.prior then
                    if cur then
                        --table.remove(out, cur._idx)
                        --for x = cur._idx, #out do
                        g_t_remove(out,cur._idx)
                        i_out_count = i_out_count -1
                        for x = cur._idx, i_out_count do
                            out[x]._idx = x
                        end
                    end
                else
                    insert = false
                end
            end
            if insert then
                v.e = e
                if v.group then
                    group[v.group] = v
                end
                --table.insert(out, v)
                --v._idx = #out
                i_out_count = i_out_count + 1
                out[i_out_count] = v
                v._idx = i_out_count
            end
        end
    end
    table.sort(out, cmp_event)
end

function t.add_wait(ED, p)
    if p.mono then
        if can_log_detail then 
            print('--== gevent add_wait mono', p[1], ED, ED.mono_wait)
        end
        --g_t_insert(ED.mono_wait, 1, p)
        g_t_insert(ED.mono_wait,p)
        return
    end
	-- if p.prior then -- low
	-- 	table.insert(ED.wait,1, p)
	-- else
    --     local pos = 0
    --     for k = 1, #ED.wait do
    --         if ED.wait[k].prior then
    --             pos = k
    --         else
    --             break
    --         end
    --     end
    -- 	table.insert(ED.wait,pos + 1, p)
    -- end
    local wait = ED.wait[p[1]] or {}
    ED.wait[p[1]] = wait
    if can_log_detail then 
        print('--== gevent add_wait', p[1], ED, ED.wait, ED.wait[p[1]])
    end
  
    --g_t_insert(wait,1, p)
    g_t_insert(wait,p)
end

function t.removeby_co(wait, pco)
    -- FIXME: 换成哈希表
    if pco == nil then return end

--    local count = 0
    for k = #wait, 1, -1 do
        if wait[k].co == pco then
            g_t_remove(wait,k)
--            count = count + 1
        end
    end
--    if count > 1 then
--        print(pco,'removeby_co end',count,#wait)
--    end
end
function t.removeby_name(wait, name_tab, name)
    -- FIXME: 换成哈希表
--    local count = 0
    for k = #wait, 1, -1 do
        local pco = wait[k].co
        if name_tab[pco] == name then
            g_t_remove(wait,k)
--            count = count + 1
        end
    end
--    if count > 1 then
--        print(name,'removeby_name end',count,#wait)
--    end
end

function t.remove_wait(ED, p)
    local mono_wait = ED.mono_wait
    if g_type(p) == 'table' then
        if #mono_wait > 0 and mono_wait[1].co == p.co then
            for k = 1, #mono_wait do
                mono_wait[k] = nil
            end
        end

        if p.co  ~= nil then
            for _,wait in pairs(ED.wait) do
                t.removeby_co(wait,p.co)
            end
            t.removeby_co(ED.pending_start,p.co)
            t.removeby_co(ED.pending_running,p.co)
        end
        if #ED.pending_running < ED.lock_pending_running_idx then
            ED.lock_pending_running_idx = #ED.pending_running
        end
        return
    end

    if #mono_wait > 0 and ED.name[mono_wait[1].co] == p then
        for k = 1, #mono_wait do
            mono_wait[k] = nil
        end
    end

    for _,wait in pairs(ED.wait) do
        t.removeby_name(wait,ED.name,p)
    end
    t.removeby_name(ED.pending_start,ED.name,p)
    t.removeby_name(ED.pending_running,ED.name,p)
    if #ED.pending_running < ED.lock_pending_running_idx then
        ED.lock_pending_running_idx = #ED.pending_running
    end

    for k,v in pairs(ED.name) do
        if v == p then
            ED.name[k] = nil
        end
    end
end

function t.start_program(ED,name, func, arg, exit_cb)
    if can_log_detail then 
        print('--== start_program ', ED, name, func, arg, exit_cb)
    end
    local p = {co = co.create(func, nil, exit_cb, ED.co_pool), arg = arg}
    ED.name[p.co] = name
    g_t_insert(ED.pending_start, p) -- start_program按开启顺序加入执行队列
    return p
end

function t.tick_event(ED, waiting, e, actived)
    if waiting == nil then 
        if can_log_detail then 
            if not string.find(e[1], '等待下一帧') then 
                print('--== gevent->tick_event no waiting', ED, e[1])
            end
        end
        return 
    end
    local out = {}
    collect_match(waiting, e, out)
    if #out >= 0 then
        t.try_send_net_event(e)
    end
    if can_log_detail then 
        if not string.find(e[1], '等待下一帧') then 
            if #out == 0 then 
                print('--== 事件没有找到匹配监听', e[1])
            else
                print('--== co name', ED.name[out[1].co])
            end
        end
    end
    if not actived then
        return out[1]
    end
    for k = #out, 1, -1  do
        out[k].main_thread = e.main_thread
        g_t_insert(actived, out[k])
    end
end

function t.next_pending(ED)
    local p

    if t.IsEventAndProgramQueueLocked(ED) then 
        if #ED.pending_start > ED.lock_pending_start_idx then 
            p = g_t_remove(ED.pending_start, ED.lock_pending_start_idx + 1)
        end
    else
        p = g_t_remove(ED.pending_start, 1)
    end 
    if p then 
        if can_log_detail then 
            print('--== start_program run', ED.name[p.co])
        end
        return p 
    end

    local actived = ED.pending_running
    if ED.stop then
        for k,_ in pairs(actived) do
            actived[k] = nil
        end
    end
    if g_type(ED.lock_pending_running_idx) ~= 'number' then
        ED.lock_pending_running_idx = -1
    end
    if g_type(ED.lock_event_queue_idx) ~= 'number' then
        ED.lock_event_queue_idx = -1
    end
    while (not t.IsEventAndProgramQueueLocked(ED) and #actived == 0) or (t.IsEventAndProgramQueueLocked(ED) and #actived <= ED.lock_pending_running_idx) do
        local ev
        local idx
        if #ED.event <= ED.lock_event_queue_idx then
            ev = nil
        else
            if t.IsEventAndProgramQueueLocked(ED) then
                idx = ED.lock_event_queue_idx + 1
            else
                idx = 1
            end
            ev = g_t_remove(ED.event, idx)
            if can_log_detail then 
                if ev and not string.find(ev[1], '等待下一帧') then 
                    print('--== try event', ev[1])
                end
            end
        end
        if ev == nil then
            break
        end
        t.tick_event(ED, ED.wait[ev[1]], ev, ED.pending_running)
    end
    if t.IsEventAndProgramQueueLocked(ED) then 
        p = g_t_remove(actived, ED.lock_pending_running_idx + 1)
    else
        p = g_t_remove(actived, 1)
    end
    if p == nil then return end
    ED.stop = p.stop
    return p
end

function t.tick(ED)
    if #ED.mono_wait > 0 then
        if ED.mono_run then
            local p = ED.mono_run
            ED.mono_run = nil
            resume_wait(ED, p)
        end
        t.try_tick_mono_wait(ED)
        return
    end
    local G = require 'gf'
    while true do
	    G.set_readonly(false)
        local p = t.next_pending(ED)
        G.set_readonly(true)
        if p then
            resume_wait(ED,p)
            if #ED.mono_wait > 0 then
                break
            end
        else
            break
        end
    end
end

function t.try_tick_mono_wait(ED)
    local mono_wait_event
    --if not (g_type(ED.mono_wait) == 'table' and g_type(ED.mono_wait[1]) == 'table') then
    if not (g_type(ED.mono_wait) == 'table' and g_type(ED.mono_wait[#ED.mono_wait]) == 'table') then
        return
    end
    --mono_wait_event = ED.mono_wait[1][1]
    mono_wait_event = ED.mono_wait[#ED.mono_wait][1]
    for i = 1, #ED.event do
        if ED.event[i][1] == mono_wait_event then
            local earg = ED.event[i]
            g_t_remove(ED.event, i)
            local p = t.tick_event(ED, ED.mono_wait, earg)
            if p then
                p.main_thread = true
                ED.mono_run = p
            end
            return
        end
    end
end
----------------------------------------
local save_count = 0
function t.trig_event(ED,proc_cb, ev,p,...)
    if g_type(ev) ~= 'string' then return end
    ev = t.parse_event(ev)
--    if string.find(ev,'下一帧') == nil then
--        print('==== trig_event ', ED,proc_cb, ev,p,...)
--    end
    --local la = ED.last_arg
    local arg = {ev,p, ...}
    local GF = require 'gf'
    arg.main_thread = not proc_cb
    if GF.isServer() then
    else
        if string.find(arg[1],'下一帧') == nil then
            if SAVE_EVENT_COUNT_LIST[arg[1]] and GF.needSave ~= true then
                save_count = save_count + 1
            end
            if SAVE_EVENT_COUNT == save_count and GF.needSave ~= true then
                save_count = 0
                GF.needSave = true
            end
            if SAVE_EVENT_LIST[arg[1]] then 
                GF.needSave = true
            end
        end
    end

    if #ED.mono_wait > 0 then
        local p = t.tick_event(ED, ED.mono_wait, arg)
        if p then
            p.main_thread = not proc_cb
            ED.mono_run = p
        else
            if can_log_detail then 
                if not string.find(arg[1], '等待下一帧') then 
                    print('--== 事件可能丢失', arg[1])
                end
            end
        end
        return
    end
    --table.insert(ED.event, arg) -- next frame
    if can_log_detail then 
        if not string.find(arg[1], '等待下一帧') then 
            print('--== [gevent] add into queue', arg[1])
        end
    end
    g_t_insert(ED.event, arg) -- next frame
    if proc_cb then
        t.tick_callback(ED,arg) -- immediate
    end
end

function t.parse_event(str)
    local pos = g_s_find(str,'@')
    if pos == nil then return str,'' end
    local ev = g_s_sub(str, 1, pos - 1)
    local txt = g_s_sub(str, pos + 1)
    return ev, txt
end

function t.parse_string(str,GF)
    local function parse(_str)
        local pf1,pf2 = g_s_find(_str,'@')
        local pf3,pf4 = g_s_find(_str,'#')
        if pf1 == nil or pf3 == nil then return _str end
        local str1 = g_s_sub(_str, 1, pf1 - 1)
        local str2 = g_s_sub(_str, pf4+1)
        local func = g_s_sub(_str,  pf2+1, pf3-1)
        local ret = GF.call(func)
        return str1 .. tostring(ret) .. parse(str2)
    end
    return parse(str)
end

-------------------------------------------
function t.add_callback(ED, cb, earg)
    local ev = earg[1]
    local cbs = ED.callback[ev] or {}
    ED.callback[ev] = cbs
    earg.cb = cb
    g_t_insert(cbs, earg)
end

function t.remove_callback(ED, cb, ev_name)
    local cbs = ED.callback[ev_name]
    if cbs == nil then return end
    for k = #cbs,1, -1 do
        local v = cbs[k]
        if v.cb == cb and v[1] == ev_name then
            g_t_remove(cbs, k)
            break
        end
    end
end

function t.tick_callback(ED,e) -- event
    local ev = e[1]
    if ev == nil then return end
    local cbs = ED.callback[ev]
    if cbs == nil then return end
    local call = {}
    collect_match(cbs, e, call)
    for k = 1, #call do
        local GF = require 'gf'
        GF.setevent_info(e)
        call[k].cb(table.unpack(e, 2, 100))
    end
end

-- 清空事件队列
-- @params(table)  ED: 事件系统数据
function t.clear_event_queue(ED)
    ED.event = {}
end

function t.get_co(ED, name)
    for co,v in pairs(ED.name) do
        if v == name then
            return co
        end
    end
end

-- 锁定事件与协程队列
function t.LockEventAndProgramQueue(ED)
    if t.IsEventAndProgramQueueLocked(ED) then 
        return 
    end

    t.LockEventQueue(ED)
    t.LockProgramQueue(ED)
    ED.lock_count = ED.lock_count + 1
end

-- 锁定事件队列, 队列中未处理完毕的事件暂时不予以处理
function t.LockEventQueue(ED)
    ED.lock_event_queue_idx = #ED.event
end

-- 锁定协程队列
function t.LockProgramQueue(ED)
    ED.lock_pending_running_idx = #ED.pending_running
    ED.lock_pending_start_idx = #ED.pending_start
end

-- 解锁事件队列
function t.UnlockEventAndProgramQueue(ED)
    ED.lock_count = ED.lock_count - 1
    if ED.lock_count <= 0 then
        t.UnlockEventQueue(ED)
        t.UnlockProgramQueue(ED)
        ED.lock_count = 0
    end
end

function t.UnlockEventQueue(ED)
    ED.lock_event_queue_idx = -1
end

function t.UnlockProgramQueue(ED)
    ED.lock_pending_running_idx = -1
    ED.lock_pending_start_idx = -1
end

-- 判断是否处于锁定状态
function t.IsEventAndProgramQueueLocked(ED)
    return ED.lock_count > 0
end

function t.try_send_net_event(earg)
    local GF = require 'gf'
    if not GF.isServer() and GF.can_trig_net_event then 
        if earg.main_thread and GF.can_trig_net_event(table.unpack(earg, 1, 99)) then
            GF.trig_net_event(table.unpack(earg, 1, 99))
        end
    end
end

function t.IsEventInQueue(ED, event_name)
	if ED.event then 
		for index, earg in ipairs(ED.event) do 
			if earg[1] == event_name then 
				return true
			end
		end
	end
    return false
end

function t.IsEventWaitExist(ED, event_name)
    if not (type(event_name) == 'string' and ED.wait[event_name] ~= nil and #ED.wait[event_name] > 0) then 
        return false
    end
    for index, event_info in ipairs(ED.wait[event_name]) do 
        if not (type(event_info.cond) == 'function' and event_info.cond() ~= true) then 
            return true
        end
    end
    return false
end

return t
