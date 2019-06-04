--[[2006

]]
local G = require 'gf'
local c_button = require 'c_button'
local c_notification = require 'c_notification'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_notification'
tc.left = -300.000
tc.right = 300.000
tc.bottom = -240.000
tc.top = 240.000
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '提示框'
	tc.left = -194.500
	tc.right = 194.500
	tc.bottom = -67.000
	tc.top = 67.000
	tc.img = 0x56010037
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '透明遮挡'
		tc.left = -300.000
		tc.right = 300.000
		tc.bottom = -240.000
		tc.top = 240.000
		tc.mouseEnabled = true
		tc.alpha = 0
		tc.img = 0x56000001
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '标题'
		tc.left = -320.000
		tc.right = 320.000
		tc.bottom = 3.000
		tc.top = 51.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '提示!!'
		tc.font = 0x60280000
		tc.style = 3
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '提示'
		tc.left = -320.000
		tc.right = 320.000
		tc.bottom = -100.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '获得 某物品'
		tc.font = 0x60300000
		tc.style = 2
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '等待'
		tc.left = 164.000
		tc.right = 180.000
		tc.bottom = -48.000
		tc.top = -32.000
		tc.img = 0x33000002
		tp = tc
		tp = tp.parent
		--end
		tc = G.Layout()
		tp.addChild(tc)
		tc.name = '按钮组'
		tc.left = -160.000
		tc.right = 160.000
		tc.bottom = -50.000
		tc.top = -18.000
		tc.spacing = 4.000
		tc.align = 5
		tp = tc
			tc = G.loadUI('v_button')
			tp.addChild(tc)
			tc.name = '按钮模板1'
			tc.left = -32.000
			tc.right = 32.000
			tc.bottom = -12.000
			tc.top = 12.000
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
				tc.text = '确定'
				tc.font = 0x60120000
				tc.wordSpace = 8
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
			tp = tp.parent
			--end
		tp = tp.parent
		--end
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '输入框'
	tc.left = -194.500
	tc.right = 194.500
	tc.bottom = -67.000
	tc.top = 67.000
	tc.visible = false
	tc.img = 0x56010037
	tp = tc
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '标题'
		tc.left = -320.000
		tc.right = 320.000
		tc.bottom = 3.000
		tc.top = 51.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '输入自创武功名称（限五个汉字）'
		tc.font = 0x60280000
		tc.style = 3
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '边框'
		tc.left = -146.000
		tc.right = 50.000
		tc.bottom = -26.000
		tc.top = 2.000
		tc.color = 0x0
		tc.img = 0x56000001
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '输入'
		tc.left = -240.000
		tc.right = 144.000
		tc.bottom = -36.000
		tc.top = 12.000
		tc.mouseEnabled = true
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '还我漂漂拳'
		tc.img = 0x56000001
		tc.readOnly = false
		tc.font = 0x60300000
		tc.align = 4
		tc.alignOffset = 4
		tc.style = 2
		tp = tc
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '确定'
		tc.left = 81.000
		tc.right = 145.000
		tc.bottom = -24.000
		tc.top = 0.000
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
			tc.left = -40.000
			tc.right = 40.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '确定'
			tc.font = 0x60240000
			tc.wordSpace = 8
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
		tp = tp.parent
		--end
	tp = tp.parent
	--end
	tc = G.Entity()
	tp.addChild(tc)
	tc.name = '全屏字幕'
	tc.right = 0.000
	tc.top = 0.000
	tc.anchor = 0x64006400
	tc.visible = false
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '背景'
		tc.right = 0.000
		tc.top = 0.000
		tc.anchor = 0x64006400
		tc.mouseEnabled = true
		tc.color = 0x0
		tc.img = 0x56000001
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '文本'
		tc.pivotY = 1.000
		tc.left = -480.000
		tc.right = 480.000
		tc.bottom = -328.000
		tc.top = 200.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.autosize = 2
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '    嵩山封禅台上的比剑夺帅仍在继续着……[br]    虽然事先已经言明是点到为止，但是越到最后，参加比试的越是功力高深，稍有失手，对方就是非死就重伤。左冷禅却视而不见，似对如此伤亡早在预料之中。[br]    华山派掌门岳不群力挫其他门派掌门，最终与左冷禅逐决这五岳掌门之位。[br]    岳不群在原本势均力敌的情况下，突然使出以诡异莫名的剑法，刺瞎了左冷禅的双眼，获得比剑夺帅的最终胜利，成为五岳派第一任掌门！'
		tc.wrap = true
		tc.font = 0x60300000
		tc.align = 1
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '等待'
			tc.left = -16.000
			tc.right = 0.000
			tc.bottom = 8.000
			tc.top = 24.000
			tc.anchor = 0x6464
			tc.img = 0x33000002
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '遮罩'
		tc.pivotY = 0.000
		tc.right = 0.000
		tc.bottom = 32.000
		tc.top = 160.000
		tc.anchor = 0x6400
		tc.img = 0x56010040
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '遮罩2'
		tc.pivotY = 0.000
		tc.right = 0.000
		tc.top = 32.000
		tc.anchor = 0x6400
		tc.color = 0x0
		tc.img = 0x56000001
		tp = tc
		tp = tp.parent
		--end
	tp = tp.parent
	--end
	tc = G.loadUI('v_button')
	tp.addChild(tc)
	tc.name = '按钮模板'
	tc.left = -32.000
	tc.right = 32.000
	tc.bottom = -48.000
	tc.top = -24.000
	tc.visible = false
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
		tc.left = -40.000
		tc.right = 40.000
		tc.bottom = -18.000
		tc.top = 18.000
		tc.anchor = 0x32323232
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.autosize = 3
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '确定'
		tc.font = 0x60240000
		tc.wordSpace = 8
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
	tp = tp.parent
	--end
	tc = G.TextQuad()
	tp.addChild(tc)
	tc.name = '飘字'
	tc.left = -256.000
	tc.right = 256.000
	tc.bottom = -132.000
	tc.top = -68.000
	tc.scaleX = 0.500
	tc.scaleY = 0.500
	tc.color = 0xff
	tc.shadowX = 1
	tc.shadowAlpha = 192
	tc.text = '修为提升'
	tc.font = 0x62300000
	tp = tc
	tp = tp.parent
	--end
	tc = G.Entity()
	tp.addChild(tc)
	tc.name = '右下'
	tc.left = 122.000
	tc.right = 222.000
	tc.bottom = -190.000
	tc.top = -90.000
	tp = tc
	tp = tp.parent
	--end
	tc = G.Entity()
	tp.addChild(tc)
	tc.name = '右上'
	tc.left = 122.000
	tc.right = 222.000
	tc.bottom = 90.000
	tc.top = 190.000
	tp = tc
	tp = tp.parent
	--end
	tc = G.Entity()
	tp.addChild(tc)
	tc.name = '左上'
	tc.left = -222.000
	tc.right = -122.000
	tc.bottom = 90.000
	tc.top = 190.000
	tp = tc
	tp = tp.parent
	--end
	tc = G.Entity()
	tp.addChild(tc)
	tc.name = '左下'
	tc.left = -222.000
	tc.right = -122.000
	tc.bottom = -190.000
	tc.top = -90.000
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '等级上升'
	tc.left = -60.000
	tc.right = 60.000
	tc.bottom = -168.500
	tc.top = -131.500
	tc.img = 0x56011047
	tp = tc
	tp = tp.parent
	--end
tp.c_notification = setmetatable({}, c_notification)
