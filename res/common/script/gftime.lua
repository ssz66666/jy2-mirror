
local GF = require "gfbase"

local time_offset = 0

function GF.setSvTime(t)
	time_offset = t - os.time()
end

function GF.getSvTime()
	return os.time() + time_offset
end

function GF.timeStr( offset )
	local h,m,s
	if offset > 3600 then -- 1 hour
		h = math.floor(offset / 3600)
		m = math.floor((offset - h * 3600) / 60)
		return c.T(18,h)..c.T(19,m)
	elseif offset > 60 then
		m = math.floor(offset / 60)
		s = offset - m * 60
		return c.T(19,m)..c.T(20,s)
	else
		return c.T(20,offset)
	end
end