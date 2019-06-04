
local function loadserver()
	local t = require 'skynet'
	return type(t) == 'table'
end


if loadserver() then
	coroutine = require "skynet.coroutine"
end

local co = {
	running = coroutine.running,
	resume = coroutine.resume,
	yield = coroutine.yield,
	status = coroutine.status,
}

local weak_meta = {__mode = 'kv'}
local weak_metav = {__mode = 'v'}
local weak_metak = {__mode = 'k'}
co.weak_meta = weak_meta

function _G.__on_error()
end

local function co_error(e)
	print("coroutine error",e)
	local GF = require 'gf'
	if GF.errorLog then
		GF.errorLog("coroutine error",e)
	end
	local errstr = debug.traceback()
	print(errstr)
	if GF.errorLog then
		GF.errorLog(errstr)
	end
	if GF.MsgBox then
		GF.MsgBox(e..errstr,'error',0)
	end

	if GF.kickOutMsg then
		GF.kickOutMsg(e..errstr)
	end
end
co.error = co_error

function co.create(f,p,on_exit, co_pool)
	assert(f)
	local ct = table.remove(co_pool)
	if ct == nil then
		ct = coroutine.create(function(...)
			xpcall(f,co_error,...)
			while true do
				f = nil
				if on_exit then
					xpcall(on_exit,co_error,ct)
				end
				co_pool[#co_pool+1] = ct
				--print("exit")
				f, on_exit = co.yield("EXIT")
				xpcall(f,co_error,co.yield())
			end
		end)
	else
		co.resume(ct, f, on_exit)
	end
	return ct
end




return co