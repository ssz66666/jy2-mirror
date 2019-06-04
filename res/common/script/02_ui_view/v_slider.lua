--[[2104

]]
local G = require 'gf'
local c_slider = require 'c_slider'
local c_button = require 'c_button'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_slider'
tc.pivotX = 0.000
tc.pivotY = 0.000
tc.right = 418.000
tc.top = 22.000
tc.anchor = 0x0
tc.mouseEnabled = true
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = 'Background'
	tc.pivotX = 0.000
	tc.pivotY = 0.000
	tc.right = 0.000
	tc.top = 0.000
	tc.anchor = 0x64006400
	tc.img = 0x5625000a
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = 'Fill'
	tc.pivotX = 0.000
	tc.pivotY = 0.000
	tc.left = 9.000
	tc.right = -9.000
	tc.bottom = 2.000
	tc.top = -2.000
	tc.anchor = 0x64000000
	tc.img = 0x5625000b
	tp = tc
	tp = tp.parent
	--end
	tc = G.loadUI('v_button')
	tp.addChild(tc)
	tc.name = 'Handle'
	tc.pivotX = 0.000
	tc.pivotY = 0.000
	tc.left = -20.000
	tc.right = 51.000
	tc.bottom = -1.000
	tc.top = 70.000
	tc.anchor = 0x6464
	tc.scaleX = 0.350
	tc.scaleY = 0.350
	tc.color = 0xfefeff
	tp = tc
		tc = tp.getChildByName('img')
		if tc then
		tc.pivotX = 0.000
		tc.pivotY = 0.000
		tc.img = 0x56280018
		tp = tc
		end
		tp = tp.parent
		--end
	com = tp.c_button
	com['img_normal'] =1445462040.000
	com['img_hover'] =1445462041.000
	com['img_press'] =1445462039.000
	tp = tp.parent
	--end
tp.c_slider = setmetatable({}, c_slider)
com = tp.c_slider
com['Percent'] =0.000
com['Direction'] =nil
com['Background'] =nil
com['Fill'] =nil
com['Handle'] =nil
