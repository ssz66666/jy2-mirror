--[[2004

]]
local G = require 'gf'
local c_scene = require 'c_scene'
local c_button = require 'c_button'
local c_framelist = require 'c_framelist'
local c_handle_click = require 'c_handle_click'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_scene'
tc.left = -300.000
tc.right = 300.000
tc.bottom = -240.000
tc.top = 240.000
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '背景图片'
	tc.right = 0.000
	tc.bottom = -240.000
	tc.top = 240.000
	tc.anchor = 0x32326400
	tc.autosize = 5
	tc.img = 0x56060002
	tp = tc
	tp = tp.parent
	--end
	tc = G.Entity()
	tp.addChild(tc)
	tc.name = '主地图地点'
	tc.left = -300.000
	tc.right = 300.000
	tc.bottom = -240.000
	tc.top = 240.000
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '主地图'
		tc.left = -300.000
		tc.right = 300.000
		tc.bottom = -240.000
		tc.top = 240.000
		tc.autosize = 5
		tc.img = 0x56060002
		tp = tc
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '少林寺'
		tc.left = -31.000
		tc.right = 25.000
		tc.bottom = 37.000
		tc.top = 59.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '少林寺'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='少林寺'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='少林寺'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '嵩山派'
		tc.left = 28.000
		tc.right = 84.000
		tc.bottom = 39.000
		tc.top = 61.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '嵩山派'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='嵩山派'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='嵩山派'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '聚贤庄'
		tc.left = 104.000
		tc.right = 160.000
		tc.bottom = 56.000
		tc.top = 78.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '聚贤庄'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='聚贤庄'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='聚贤庄'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '华山派'
		tc.left = -103.000
		tc.right = -47.000
		tc.bottom = 59.000
		tc.top = 81.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '华山派'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='华山派'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='华山派'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '长白山'
		tc.left = 71.000
		tc.right = 127.000
		tc.bottom = 175.000
		tc.top = 197.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '长白山'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='长白山'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='长白山'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '昆仑派'
		tc.left = -225.000
		tc.right = -169.000
		tc.bottom = 173.000
		tc.top = 195.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '昆仑派'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='昆仑派'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='昆仑派'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '青城派'
		tc.left = -245.000
		tc.right = -189.000
		tc.bottom = 11.000
		tc.top = 33.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '青城派'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='青城派'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='青城派'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '武当派'
		tc.left = -79.000
		tc.right = -23.000
		tc.bottom = -36.000
		tc.top = -14.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '武当派'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='武当派'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='武当派'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '黑木崖'
		tc.left = -254.000
		tc.right = -198.000
		tc.bottom = -105.000
		tc.top = -83.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '黑木崖'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='黑木崖'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='黑木崖'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '万劫谷'
		tc.left = -239.000
		tc.right = -183.000
		tc.bottom = -225.000
		tc.top = -203.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '万劫谷'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='万劫谷'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='万劫谷'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '天龙寺'
		tc.left = -140.000
		tc.right = -84.000
		tc.bottom = -175.000
		tc.top = -153.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '天龙寺'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='天龙寺'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='天龙寺'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '襄阳城'
		tc.left = 48.000
		tc.right = 104.000
		tc.bottom = -78.000
		tc.top = -56.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '襄阳城'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='襄阳城'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='襄阳城'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '百花谷'
		tc.left = 63.000
		tc.right = 119.000
		tc.bottom = -136.000
		tc.top = -114.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '百花谷'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='百花谷'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='百花谷'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '铸剑谷'
		tc.left = 142.000
		tc.right = 198.000
		tc.bottom = -149.000
		tc.top = -127.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '铸剑谷'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='铸剑谷'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='铸剑谷'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '主角家'
		tc.left = 22.000
		tc.right = 78.000
		tc.bottom = -175.000
		tc.top = -153.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '主角家'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='主角家'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='主角家'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '衡阳城'
		tc.left = 65.000
		tc.right = 121.000
		tc.bottom = -225.000
		tc.top = -203.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -52.000
			tc.right = 52.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '衡阳城'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='衡阳城'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='衡阳城'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '渡口'
		tc.left = 213.000
		tc.right = 257.000
		tc.bottom = -129.000
		tc.top = -107.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -37.000
			tc.right = 37.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '渡口'
			tc.font = 0x60240000
			tc.wordSpace = 2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='渡口'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='渡口'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '剑冢'
		tc.left = 1.000
		tc.right = 45.000
		tc.bottom = -3.000
		tc.top = 19.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -37.000
			tc.right = 37.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '剑冢'
			tc.font = 0x60240000
			tc.wordSpace = 2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='剑冢'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='剑冢'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '破庙'
		tc.left = -167.000
		tc.right = -123.000
		tc.bottom = -94.000
		tc.top = -72.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -37.000
			tc.right = 37.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '破庙'
			tc.font = 0x60240000
			tc.wordSpace = 2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='破庙'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='破庙'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '明教总坛'
		tc.left = -216.000
		tc.right = -144.000
		tc.bottom = 132.000
		tc.top = 154.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -69.000
			tc.right = 69.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '明教总坛'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='明教总坛'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='明教总坛'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '华山之巅'
		tc.left = -103.000
		tc.right = -31.000
		tc.bottom = 97.000
		tc.top = 119.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -69.000
			tc.right = 69.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '华山之巅'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='华山之巅'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='华山之巅'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '福威镖局'
		tc.left = 137.000
		tc.right = 209.000
		tc.bottom = -191.000
		tc.top = -169.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -69.000
			tc.right = 69.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '福威镖局'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='福威镖局'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='福威镖局'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '无量山洞'
		tc.left = -76.000
		tc.right = -4.000
		tc.bottom = -191.000
		tc.top = -169.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601007f
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -69.000
			tc.right = 69.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '无量山洞'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='无量山洞'
		com['customsize'] =true
		com['img_normal'] =1442906239.000
		com['img_hover'] =1442906238.000
		com['img_press'] =1442906235.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='无量山洞'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '战斗1'
		tc.left = -225.000
		tc.right = -191.000
		tc.bottom = 82.000
		tc.top = 116.000
		tc.mouseEnabled = true
		tc.img = 0x33000005
		tp = tc
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='战斗1'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '战斗2'
		tc.left = -15.000
		tc.right = 19.000
		tc.bottom = -52.000
		tc.top = -18.000
		tc.mouseEnabled = true
		tc.img = 0x33000005
		tp = tc
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='战斗1'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '战斗3'
		tc.left = -260.000
		tc.right = -226.000
		tc.bottom = -192.000
		tc.top = -158.000
		tc.mouseEnabled = true
		tc.img = 0x33000005
		tp = tc
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='战斗1'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '战斗4'
		tc.left = -116.000
		tc.right = -82.000
		tc.bottom = -4.000
		tc.top = 30.000
		tc.mouseEnabled = true
		tc.img = 0x33000006
		tp = tc
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='战斗2'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '主界面'
	tc.pivotX = 0.000
	tc.pivotY = 1.000
	tc.left = 2.000
	tc.right = 199.000
	tc.bottom = -79.000
	tc.top = -2.000
	tc.anchor = 0x64640000
	tc.img = 0x56010041
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '头像'
		tc.left = -86.500
		tc.right = -47.500
		tc.bottom = -24.500
		tc.top = 24.500
		tc.scaleX = -1.000
		tc.img = 0x56020001
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '姓名'
		tc.left = -109.000
		tc.right = 83.000
		tc.bottom = 4.000
		tc.top = 40.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '张三李四'
		tc.font = 0x60200000
		tc.wordSpace = -1
		tc.style = 2
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '称号'
		tc.left = -24.000
		tc.right = 136.000
		tc.bottom = 4.000
		tc.top = 34.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '江湖小笑笑'
		tc.font = 0x601c0000
		tc.wordSpace = -1
		tc.style = 2
		tp = tc
		tp = tp.parent
		--end
		tc = G.Layout()
		tp.addChild(tc)
		tc.name = '属性'
		tc.left = -38.500
		tc.right = 78.500
		tc.bottom = -27.000
		tc.top = 3.000
		tc.layoutMode = 1
		tc.padLeft = 27.000
		tc.spacing = 2.000
		tp = tc
			tc = G.Entity()
			tp.addChild(tc)
			tc.name = '生命'
			tc.left = -31.500
			tc.right = 58.500
			tc.bottom = 6.000
			tc.top = 15.000
			tp = tc
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '边框'
				tc.right = 0.000
				tc.top = 0.000
				tc.anchor = 0x64006400
				tc.color = 0x656666
				tc.img = 0x56000001
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '底色'
				tc.left = 1.000
				tc.right = -1.000
				tc.bottom = 1.000
				tc.top = -1.000
				tc.anchor = 0x64006400
				tc.color = 0xcccccc
				tc.img = 0x56000001
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '进度条'
				tc.pivotX = 0.000
				tc.right = 70.000
				tc.bottom = 1.000
				tc.top = -1.000
				tc.anchor = 0x64000000
				tc.color = 0x6262ff
				tc.img = 0x56011037
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '标签'
				tc.pivotX = 0.000
				tc.left = -28.000
				tc.right = 36.000
				tc.bottom = -14.000
				tc.top = 14.000
				tc.anchor = 0x32320000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '生命'
				tc.font = 0x61180000
				tc.align = 4
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
			tc = G.Entity()
			tp.addChild(tc)
			tc.name = '内力'
			tc.left = -31.500
			tc.right = 58.500
			tc.bottom = -5.000
			tc.top = 4.000
			tp = tc
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '边框'
				tc.right = 0.000
				tc.top = 0.000
				tc.anchor = 0x64006400
				tc.color = 0x656666
				tc.img = 0x56000001
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '底色'
				tc.left = 1.000
				tc.right = -1.000
				tc.bottom = 1.000
				tc.top = -1.000
				tc.anchor = 0x64006400
				tc.color = 0xcccccc
				tc.img = 0x56000001
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '进度条'
				tc.pivotX = 0.000
				tc.right = 50.000
				tc.bottom = 1.000
				tc.top = -1.000
				tc.anchor = 0x64000000
				tc.color = 0xff913d
				tc.img = 0x56011037
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '标签'
				tc.pivotX = 0.000
				tc.left = -28.000
				tc.right = 36.000
				tc.bottom = -14.000
				tc.top = 14.000
				tc.anchor = 0x32320000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '内力'
				tc.font = 0x61180000
				tc.align = 4
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
			tc = G.Entity()
			tp.addChild(tc)
			tc.name = '经验'
			tc.left = -31.500
			tc.right = 58.500
			tc.bottom = -16.000
			tc.top = -7.000
			tp = tc
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '边框'
				tc.right = 0.000
				tc.top = 0.000
				tc.anchor = 0x64006400
				tc.color = 0x656666
				tc.img = 0x56000001
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '底色'
				tc.left = 1.000
				tc.right = -1.000
				tc.bottom = 1.000
				tc.top = -1.000
				tc.anchor = 0x64006400
				tc.color = 0xcccccc
				tc.img = 0x56000001
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '进度条'
				tc.pivotX = 0.000
				tc.right = 72.000
				tc.bottom = 1.000
				tc.top = -1.000
				tc.anchor = 0x64000000
				tc.color = 0x8bffff
				tc.img = 0x56011037
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '标签'
				tc.pivotX = 0.000
				tc.left = -28.000
				tc.right = 36.000
				tc.bottom = -14.000
				tc.top = 14.000
				tc.anchor = 0x32320000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '经验'
				tc.font = 0x61180000
				tc.align = 4
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '透明按钮'
		tc.left = -101.000
		tc.right = 101.000
		tc.bottom = -74.500
		tc.top = -29.500
		tc.img = 0x56010042
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '人物'
			tc.pivotX = 0.000
			tc.pivotY = 1.000
			tc.right = 36.000
			tc.bottom = 4.000
			tc.top = -4.000
			tc.anchor = 0x64000000
			tc.mouseEnabled = true
			tc.alpha = 0
			tc.img = 0x56000001
			tp = tc
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='人物'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '武功'
			tc.pivotX = 0.000
			tc.pivotY = 1.000
			tc.left = 37.000
			tc.right = 71.000
			tc.bottom = 4.000
			tc.top = -4.000
			tc.anchor = 0x64000000
			tc.mouseEnabled = true
			tc.alpha = 0
			tc.img = 0x56000001
			tp = tc
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='武功'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品'
			tc.pivotX = 0.000
			tc.pivotY = 1.000
			tc.left = 72.000
			tc.right = 106.000
			tc.bottom = 4.000
			tc.top = -4.000
			tc.anchor = 0x64000000
			tc.mouseEnabled = true
			tc.alpha = 0
			tc.img = 0x56000001
			tp = tc
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='物品'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '秘籍'
			tc.pivotX = 0.000
			tc.pivotY = 1.000
			tc.left = 107.000
			tc.right = 137.000
			tc.bottom = 4.000
			tc.top = -4.000
			tc.anchor = 0x64000000
			tc.mouseEnabled = true
			tc.alpha = 0
			tc.img = 0x56000001
			tp = tc
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='秘籍'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '存档'
			tc.pivotX = 0.000
			tc.pivotY = 1.000
			tc.left = 139.000
			tc.right = 173.000
			tc.bottom = 4.000
			tc.top = -4.000
			tc.anchor = 0x64000000
			tc.mouseEnabled = true
			tc.alpha = 0
			tc.img = 0x56000001
			tp = tc
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='存档'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '退出'
			tc.pivotX = 0.000
			tc.pivotY = 1.000
			tc.left = 175.000
			tc.right = 202.000
			tc.bottom = 4.000
			tc.top = -4.000
			tc.anchor = 0x64000000
			tc.mouseEnabled = true
			tc.alpha = 0
			tc.img = 0x56000001
			tp = tc
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='退出'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
		tp = tp.parent
		--end
	tp = tp.parent
	--end
	tc = G.Layout()
	tp.addChild(tc)
	tc.name = '跳转'
	tc.pivotX = 1.000
	tc.pivotY = 0.000
	tc.left = -418.000
	tc.right = -18.000
	tc.bottom = 6.000
	tc.top = 56.000
	tc.anchor = 0x6464
	tc.spacing = 1.000
	tc.align = 6
	tp = tc
	tp = tp.parent
	--end
	tc = G.Layout()
	tp.addChild(tc)
	tc.name = '指令'
	tc.pivotX = 1.000
	tc.pivotY = 0.000
	tc.left = -88.000
	tc.right = -6.000
	tc.bottom = 18.000
	tc.top = 178.000
	tc.anchor = 0x6464
	tc.layoutMode = 1
	tc.spacing = 1.000
	tc.align = 7
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '序列帧动画'
	tc.left = -50.000
	tc.right = 50.000
	tc.bottom = -50.000
	tc.top = 50.000
	tc.visible = false
	tc.autosize = 3
	tc.img = 0x33000001
	tp = tc
	tp = tp.parent
	--end
	tc = G.Entity()
	tp.addChild(tc)
	tc.name = '组件模板'
	tc.left = -50.000
	tc.right = 50.000
	tc.bottom = -50.000
	tc.top = 50.000
	tc.visible = false
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '静态头像框'
		tc.left = -41.500
		tc.right = 41.500
		tc.bottom = -49.500
		tc.top = 49.500
		tc.img = 0x56020001
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '像框'
			tc.left = -49.500
			tc.right = 49.500
			tc.bottom = -57.500
			tc.top = 57.500
			tc.img = 0x56010033
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '交互头像框'
		tc.left = 39.000
		tc.right = 103.000
		tc.bottom = -172.500
		tc.top = -82.500
		tc.autosize = 4
		tc.img = 0x56020001
		tp = tc
			tc = G.loadUI('v_button')
			tp.addChild(tc)
			tc.name = '像框'
			tc.left = -34.000
			tc.right = 34.000
			tc.bottom = -110.500
			tc.top = -5.500
			tc.anchor = 0x64643232
			tp = tc
				tc = tp.getChildByName('img')
				if tc then
				tc.img = 0x56010036
				tp = tc
				end
				tp = tp.parent
				--end
			com = tp.c_button
			com['customsize'] =true
			com['img_normal'] =1442906166.000
			com['img_hover'] =1442906164.000
			com['img_press'] =1442906165.000
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='场景_场景交互'
			com['事件参数一'] ='模板'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '姓名'
			tc.left = -101.000
			tc.right = 99.000
			tc.bottom = -66.000
			tc.top = -26.000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '小宝货郎'
			tc.font = 0x60240000
			tc.wordSpace = -2
			tc.style = 2
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '交互头像框1'
		tc.pivotY = 1.000
		tc.left = 113.000
		tc.right = 183.000
		tc.bottom = -203.500
		tc.top = -87.500
		tc.mouseEnabled = true
		tc.autosize = 4
		tc.img = 0x56020001
		tp = tc
			tc = G.loadUI('v_button')
			tp.addChild(tc)
			tc.name = '像框'
			tc.pivotY = 1.000
			tc.left = -36.000
			tc.right = 36.000
			tc.bottom = -114.000
			tc.top = 2.000
			tc.anchor = 0x64643232
			tp = tc
				tc = tp.getChildByName('img')
				if tc then
				tc.img = 0x56010036
				tp = tc
				end
				tp = tp.parent
				--end
			com = tp.c_button
			com['customsize'] =true
			com['img_normal'] =1442906166.000
			com['img_hover'] =1442906164.000
			com['img_press'] =1442906165.000
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =nil
			com['事件名'] =nil
			com['事件参数一'] =nil
			com['事件参数二'] =nil
			tp = tp.parent
			--end
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='模板'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '按钮_指令'
		tc.left = 168.000
		tc.right = 244.000
		tc.bottom = 12.500
		tc.top = 47.500
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
			tc.left = -48.000
			tc.right = 48.000
			tc.bottom = -23.000
			tc.top = 25.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '确定'
			tc.font = 0x60300000
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='确定'
		com['customsize'] =true
		com['img_normal'] =1442906193.000
		com['img_hover'] =1442906194.000
		com['img_press'] =1442906195.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='模板'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '按钮_跳转'
		tc.left = 164.000
		tc.right = 272.000
		tc.bottom = -43.000
		tc.top = -3.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x56010057
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -48.000
			tc.right = 48.000
			tc.bottom = -24.000
			tc.top = 24.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '确定'
			tc.font = 0x60300000
			tp = tc
			end
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '图片'
			tc.left = -46.000
			tc.right = -6.000
			tc.bottom = -20.000
			tc.top = 20.000
			tc.img = 0x56010061
			tp = tc
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='确定'
		com['customsize'] =true
		com['img_normal'] =1442906199.000
		com['img_hover'] =1442906200.000
		com['img_press'] =1442906201.000
		com['audio_press'] =1224736782.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='场景_场景交互'
		com['事件参数一'] ='模板'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '战斗模型'
		tc.left = -50.000
		tc.right = 50.000
		tc.bottom = -50.000
		tc.top = 50.000
		tc.visible = false
		tc.autosize = 3
		tc.img = 0x33001001
		tp = tc
		tp.c_framelist = setmetatable({}, c_framelist)
		com = tp.c_framelist
		com['动作编号'] =nil
		com['循环播放'] =false
		tp = tp.parent
		--end
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '颜色遮罩'
	tc.right = 0.000
	tc.top = 0.000
	tc.anchor = 0x64006400
	tc.visible = false
	tc.color = 0x2c980a
	tc.alpha = 0
	tc.img = 0x56000001
	tp = tc
	tp = tp.parent
	--end
tp.c_scene = setmetatable({}, c_scene)
