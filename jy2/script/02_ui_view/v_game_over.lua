--[[2009

]]
local G = require 'gf'
local c_button = require 'c_button'
local c_handle_click = require 'c_handle_click'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_game_over'
tc.left = -640.000
tc.right = 640.000
tc.bottom = -360.000
tc.top = 360.000
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '背景'
	tc.right = 0.000
	tc.top = 0.000
	tc.anchor = 0x64006400
	tc.color = 0x0
	tc.img = 0x56000001
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '人物'
	tc.left = -128.000
	tc.right = 128.000
	tc.bottom = -66.500
	tc.top = 66.500
	tc.autosize = 5
	tc.img = 0x56011051
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '十年生死'
	tc.left = 205.500
	tc.right = 234.500
	tc.bottom = -87.000
	tc.top = 167.000
	tc.img = 0x56011052
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '不思量'
	tc.left = 155.500
	tc.right = 184.500
	tc.bottom = 63.500
	tc.top = 166.500
	tc.img = 0x56011053
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '自难忘'
	tc.left = 155.000
	tc.right = 185.000
	tc.bottom = -87.000
	tc.top = 21.000
	tc.img = 0x56011054
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '千里孤坟'
	tc.left = 104.500
	tc.right = 135.500
	tc.bottom = -167.500
	tc.top = 167.500
	tc.img = 0x56011055
	tp = tc
	tp = tp.parent
	--end
	tc = G.loadUI('v_button')
	tp.addChild(tc)
	tc.name = '重新开始'
	tc.left = -275.000
	tc.right = -237.000
	tc.bottom = -215.000
	tc.top = -85.000
	tp = tc
		tc = tp.getChildByName('img')
		if tc then
		tc.img = 0x56011056
		tp = tc
		end
		tp = tp.parent
		--end
	com = tp.c_button
	com['img_normal'] =1442910294.000
	com['img_hover'] =1442910294.000
	com['img_press'] =1442910295.000
	tp.c_handle_click = setmetatable({}, c_handle_click)
	com = tp.c_handle_click
	com['允许点击事件'] =true
	com['事件名'] ='通用_UI交互'
	com['事件参数一'] ='重新开始'
	com['事件参数二'] =nil
	tp = tp.parent
	--end
