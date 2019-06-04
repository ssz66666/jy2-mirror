--[[2003

]]
local G = require 'gf'
local c_info = require 'c_info'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_info'
tc.left = -640.000
tc.right = 640.000
tc.bottom = -360.000
tc.top = 360.000
tc.visible = false
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '信息'
	tc.left = -159.000
	tc.right = 159.000
	tc.bottom = -98.500
	tc.top = 98.500
	tc.mouseEnabled = true
	tc.img = 0x56010038
	tp = tc
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = 'FPS'
		tc.pivotX = 0.000
		tc.left = 12.000
		tc.right = 212.000
		tc.bottom = 58.500
		tc.top = 87.500
		tc.anchor = 0x32320000
		tc.sample = -1
		tc.text = 'FPS: '
		tc.font = 0x60140000
		tc.align = 4
		tc.style = 2
		tp = tc
		tp = tp.parent
		--end
	tp = tp.parent
	--end
tp.c_info = setmetatable({}, c_info)
