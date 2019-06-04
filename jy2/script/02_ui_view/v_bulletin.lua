--[[200a

]]
local G = require 'gf'
local c_handle_click = require 'c_handle_click'
local c_button = require 'c_button'
local c_bulletin = require 'c_bulletin'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_bulletin'
tc.left = -300.000
tc.right = 300.000
tc.bottom = -240.000
tc.top = 240.000
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '背景'
	tc.left = -300.000
	tc.right = 300.000
	tc.bottom = -240.000
	tc.top = 240.000
	tc.img = 0x56010013
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '网页'
	tc.left = -164.500
	tc.right = 228.500
	tc.bottom = -162.000
	tc.top = 202.000
	tc.img = 0x56000001
	tp = tc
	tp = tp.parent
	--end
	tc = G.loadUI('v_button')
	tp.addChild(tc)
	tc.name = '离开'
	tc.left = 154.000
	tc.right = 230.000
	tc.bottom = -209.500
	tc.top = -174.500
	tp = tc
		tc = tp.getChildByName('img')
		if tc then
		tc.img = 0x56010051
		tp = tc
		end
		tp = tp.parent
		--end
		tc = tp.getChildByName('text')
		if tc then
		tc.left = -52.000
		tc.right = 52.000
		tc.bottom = -24.000
		tc.top = 24.000
		tc.anchor = 0x32323232
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.autosize = 3
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '离开'
		tc.font = 0x60300000
		tc.wordSpace = 8
		tp = tc
		end
		tp = tp.parent
		--end
	com = tp.c_button
	com['text'] ='离开'
	com['customsize'] =true
	com['img_normal'] =1442906193.000
	com['img_hover'] =1442906194.000
	com['img_press'] =1442906195.000
	tp.c_handle_click = setmetatable({}, c_handle_click)
	com = tp.c_handle_click
	com['允许点击事件'] =true
	com['事件名'] ='通用_UI交互'
	com['事件参数一'] ='关闭公告'
	com['事件参数二'] =nil
	tp = tp.parent
	--end
tp.c_bulletin = setmetatable({}, c_bulletin)
com = tp.c_bulletin
com['网址'] ='https://action.17m3.com/mjh/jymini/'
