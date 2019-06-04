--[[2101

]]
local G = require 'gf'
local c_button = require 'c_button'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_button'
tc.mouseEnabled = true
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = 'img_ex'
	tc.right = 0.000
	tc.top = 0.000
	tc.anchor = 0x64006400
	tc.visible = false
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = 'img'
	tc.right = 0.000
	tc.top = 0.000
	tc.anchor = 0x64006400
	tp = tc
	tp = tp.parent
	--end
	tc = G.TextQuad()
	tp.addChild(tc)
	tc.name = 'text'
	tc.right = 0.000
	tc.top = 0.000
	tc.anchor = 0x64006400
	tc.color = 0x0
	tp = tc
	tp = tp.parent
	--end
tp.c_button = setmetatable({}, c_button)
com = tp.c_button
com['text'] =nil
com['btn_class'] =nil
com['customsize'] =false
com['img_normal'] =nil
com['color_normal'] =nil
com['img_hover'] =nil
com['color_hover'] =nil
com['audio_hover'] =nil 
com['img_press'] =nil
com['frameList_press'] =nil
com['color_press'] =nil
com['audio_press'] =nil
com['img_disable'] =nil
com['color_disable'] =nil
com['img_toggle'] =nil
com['color_toggle'] =nil
com['img_togEx'] =nil
