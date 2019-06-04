
local GF = require "gfbase"
local l_type = type
local l_rawget = rawget
local l_rawset = rawset
local set_k = {}
local k__ = {}
local function new_index(t,k,v)
	if set_k[k] == nil then
		set_k[k] = 'set_'..k
	end

	local func = t[set_k[k]]
	if l_type(func) == 'function' then
		if k__[k] == nil then
			k__[k]  = k..'__'
		end
		local oldv = l_rawget(t, k__[k])
		l_rawset(t, k__[k], v)
		func(t,oldv)
		return
	end
	l_rawset(t,k,v)
end

local com_map = setmetatable({},{__mode = 'kv'})
_G.com_map = com_map
local function _index(t,k)
	if k == 'obj' then
		return com_map[t]
	end
	if k__[k] == nil then
		k__[k]  = k..'__'
	end
	local ret = l_rawget(t, k__[k] )
	if ret ~= nil then return ret end
	return getmetatable(t)[k]
end

function GF.com(api)
	local t =  {} --setmetatable({}, com_meta)
	t.__index = _index
	t.__newindex = new_index
	return t
end