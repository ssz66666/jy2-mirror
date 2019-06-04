--[[2001

]]
local G = require 'gf'
local c_dialogue = require 'c_dialogue'
local c_scrollview = require 'c_scrollview'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_dialogue'
tc.left = -300.000
tc.right = 300.000
tc.bottom = -240.000
tc.top = 240.000
tc.mouseEnabled = true
tc.autosize = 3
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '点击响应区域'
	tc.left = 20.000
	tc.right = -20.000
	tc.bottom = 20.000
	tc.top = -20.000
	tc.anchor = 0x64006400
	tc.alpha = 0
	tc.img = 0x56000001
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '背景'
	tc.left = -290.000
	tc.right = 290.000
	tc.bottom = -228.500
	tc.top = -81.500
	tc.mouseEnabled = true
	tc.img = 0x56010031
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '头像'
		tc.left = -279.500
		tc.right = -196.500
		tc.bottom = -36.500
		tc.top = 62.500
		tc.scaleX = -1.000
		tc.img = 0x56020001
		tp = tc
		tp = tp.parent
		--end
		tc = G.Entity()
		tp.addChild(tc)
		tc.name = '选项组'
		tc.pivotY = 1.000
		tc.left = -187.000
		tc.right = 273.000
		tc.bottom = -59.000
		tc.top = 16.000
		tc.mouseEnabled = true
		tc.visible = false
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = 'mask'
			tc.right = 0.000
			tc.top = 0.000
			tc.anchor = 0x64006400
			tc.mask = 10
			tc.img = 0x56000001
			tp = tc
			tp = tp.parent
			--end
			tc = G.Layout()
			tp.addChild(tc)
			tc.name = 'content'
			tc.pivotY = 1.000
			tc.right = 1.000
			tc.bottom = -65.000
			tc.top = 0.000
			tc.anchor = 0x64646400
			tc.layoutMode = 1
			tc.spacing = 2.000
			tp = tc
				tc = G.Entity()
				tp.addChild(tc)
				tc.name = '选项1'
				tc.pivotX = 0.480
				tc.left = -230.500
				tc.right = 229.500
				tc.bottom = -23.000
				tc.top = 0.000
				tc.anchor = 0x64643232
				tp = tc
					tc = G.Quad()
					tp.addChild(tc)
					tc.name = '背景'
					tc.right = 0.000
					tc.top = 0.000
					tc.anchor = 0x64006400
					tc.visible = false
					tc.img = 0x56000001
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '文本'
					tc.pivotX = 0.000
					tc.right = 484.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.autosize = 1
					tc.text = '晚辈已经记下了. 了晚辈已经记下了晚辈已经记下了'
					tc.font = 0x60150000
					tc.align = 4
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
				tp = tp.parent
				--end
			tp = tp.parent
			--end
			tc = G.Entity()
			tp.addChild(tc)
			tc.name = 'slider'
			tc.pivotX = 1.000
			tc.left = -6.000
			tc.right = -2.000
			tc.top = 0.000
			tc.anchor = 0x64006464
			tc.visible = false
			tp = tc
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '背景'
				tc.right = 0.000
				tc.top = 0.000
				tc.anchor = 0x64006400
				tc.alpha = 128
				tc.img = 0x56000001
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '按钮'
				tc.pivotY = 1.000
				tc.right = 0.000
				tc.bottom = -41.058
				tc.top = 0.000
				tc.anchor = 0x64646400
				tc.color = 0x0
				tc.alpha = 128
				tc.img = 0x56000001
				tp = tc
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
		com['autoMove'] =false
		com['hideSlider'] =false
		tp = tp.parent
		--end
		tc = G.Entity()
		tp.addChild(tc)
		tc.name = '选项模板'
		tc.left = -230.000
		tc.right = 230.000
		tc.bottom = -11.500
		tc.top = 11.500
		tc.anchor = 0x64643232
		tc.mouseEnabled = true
		tc.visible = false
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '背景'
			tc.right = 0.000
			tc.bottom = 1.000
			tc.top = -1.000
			tc.anchor = 0x64006400
			tc.color = 0xe08080
			tc.alpha = 0
			tc.img = 0x56000001
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '文本'
			tc.pivotX = 0.000
			tc.right = 315.000
			tc.top = 0.000
			tc.anchor = 0x64000000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 1
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '晚辈已经记下了.'
			tc.font = 0x602a0000
			tc.align = 4
			tc.style = 2
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
	tp = tp.parent
	--end
	tc = G.TextQuad()
	tp.addChild(tc)
	tc.name = '姓名'
	tc.left = -226.000
	tc.right = -34.000
	tc.bottom = -131.000
	tc.top = -83.000
	tc.scaleX = 0.500
	tc.scaleY = 0.500
	tc.autosize = 3
	tc.shadowX = 1
	tc.shadowAlpha = 192
	tc.text = '逍遥奇侠'
	tc.font = 0x60300000
	tp = tc
	tp = tp.parent
	--end
	tc = G.TextQuad()
	tp.addChild(tc)
	tc.name = '对白'
	tc.pivotX = 0.000
	tc.pivotY = 1.000
	tc.left = -185.000
	tc.right = 25.000
	tc.bottom = -295.000
	tc.top = -133.000
	tc.scaleX = 0.500
	tc.scaleY = 0.500
	tc.autosize = 1
	tc.shadowX = 1
	tc.shadowAlpha = 192
	tc.text = '实在对不住[br]实在对不住[br]实在对不住'
	tc.wrap = true
	tc.font = 0x602a0000
	tc.align = 1
	tc.lineSpace = 3
	tc.style = 2
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '等待'
		tc.left = 892.000
		tc.right = 908.000
		tc.bottom = -148.000
		tc.top = -132.000
		tc.anchor = 0x64640000
		tc.scaleX = 2.000
		tc.scaleY = 2.000
		tc.img = 0x33000002
		tp = tc
		tp = tp.parent
		--end
	tp = tp.parent
	--end
tp.c_dialogue = setmetatable({}, c_dialogue)
