--[[2102

]]
local G = require 'gf'
local c_scrollview = require 'c_scrollview'
local c_button = require 'c_button'
local tp,tc,com,tk
tc = G.Quad()
G.cacheUI(tc)
tc.name = 'v_scrollview'
tc.left = -196.611
tc.right = 216.389
tc.bottom = -225.722
tc.top = 217.278
tc.mouseEnabled = true
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = 'mask'
	tc.right = 0.000
	tc.top = 0.000
	tc.anchor = 0x64006400
	tc.mouseEnabled = true
	tc.mask = 128
	tc.img = 0x56060001
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = 'content'
	tc.pivotX = 0.000
	tc.pivotY = 1.000
	tc.right = 413.000
	tc.top = 0.000
	tc.anchor = 0x64640000
	tp = tc
	tp = tp.parent
	--end
	tc = G.loadUI('v_empty')
	tp.addChild(tc)
	tc.name = 'slider'
	tc.pivotX = 0.000
	tc.pivotY = 0.000
	tc.right = 6.000
	tc.anchor = 0x64006464
	tc.visible = false
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '背景'
		tc.right = 0.000
		tc.top = 0.000
		tc.anchor = 0x64006400
		tc.img = 0x5622007f
		tp = tc
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '按钮'
		tc.pivotY = 1.000
		tc.right = 0.000
		tc.bottom = -97.000
		tc.top = 0.000
		tc.anchor = 0x64646400
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x56220080
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['customsize'] =true
		com['img_normal'] =1445068928.000
		com['img_hover'] =1445068929.000
		com['img_press'] =1445068928.000
		tp = tp.parent
		--end
	tp = tp.parent
	--end
tp.c_scrollview = setmetatable({}, c_scrollview)
com = tp.c_scrollview
com['Horizontal'] =false
com['Vertical'] =true
com['Sensitivity'] =10.000
com['type'] =0.000
com['autoMove'] =nil
