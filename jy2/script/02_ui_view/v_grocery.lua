--[[2007

]]
local G = require 'gf'
local c_grocery = require 'c_grocery'
local c_scrollview = require 'c_scrollview'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_grocery'
tc.left = -640.000
tc.right = 640.000
tc.bottom = -360.000
tc.top = 360.000
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '背景'
	tc.left = -159.000
	tc.right = 159.000
	tc.bottom = -98.500
	tc.top = 98.500
	tc.mouseEnabled = true
	tc.img = 0x56010038
	tp = tc
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '品牌'
		tc.pivotX = 0.000
		tc.left = -150.000
		tc.right = 250.000
		tc.bottom = 45.000
		tc.top = 109.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '本期最新推荐商品'
		tc.font = 0x60300000
		tc.align = 4
		tc.style = 3
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '标题'
		tc.pivotX = 0.000
		tc.left = -145.000
		tc.right = 455.000
		tc.bottom = 23.000
		tc.top = 71.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '名称      介绍        售价'
		tc.font = 0x602a0000
		tc.style = 2
		tp = tc
		tp = tp.parent
		--end
		tc = G.Entity()
		tp.addChild(tc)
		tc.name = '列表'
		tc.pivotY = 1.000
		tc.left = 8.000
		tc.right = -4.000
		tc.bottom = -56.000
		tc.top = 32.000
		tc.anchor = 0x32326400
		tc.mouseEnabled = true
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
			tc.bottom = -88.000
			tc.top = 0.000
			tc.anchor = 0x64646400
			tc.layoutMode = 1
			tc.spacing = 2.000
			tp = tc
				tc = G.Entity()
				tp.addChild(tc)
				tc.name = '选项1'
				tc.left = -153.500
				tc.right = 146.500
				tc.bottom = -20.000
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
					tc.name = '名称'
					tc.pivotX = 0.000
					tc.left = 4.000
					tc.right = 94.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '金蛇套餐'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '介绍'
					tc.pivotX = 0.000
					tc.left = 95.000
					tc.right = 260.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '金蛇郎君的遗产'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '售价'
					tc.pivotX = 0.000
					tc.left = 250.000
					tc.right = 295.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '1000'
					tc.font = 0x60120000
					tc.align = 6
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
				tp = tp.parent
				--end
				tc = G.Entity()
				tp.addChild(tc)
				tc.name = '选项11'
				tc.left = -153.500
				tc.right = 146.500
				tc.bottom = -42.000
				tc.top = -22.000
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
					tc.name = '名称'
					tc.pivotX = 0.000
					tc.left = 4.000
					tc.right = 94.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '铁剑'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '介绍'
					tc.pivotX = 0.000
					tc.left = 95.000
					tc.right = 260.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '有良好防御性的甲衣'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '售价'
					tc.pivotX = 0.000
					tc.left = 250.000
					tc.right = 295.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '1000'
					tc.font = 0x60120000
					tc.align = 6
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
				tp = tp.parent
				--end
				tc = G.Entity()
				tp.addChild(tc)
				tc.name = '选项11'
				tc.left = -153.500
				tc.right = 146.500
				tc.bottom = -64.000
				tc.top = -44.000
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
					tc.name = '名称'
					tc.pivotX = 0.000
					tc.left = 4.000
					tc.right = 94.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '九花玉露丸'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '介绍'
					tc.pivotX = 0.000
					tc.left = 95.000
					tc.right = 260.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '桃花岛秘传神药'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '售价'
					tc.pivotX = 0.000
					tc.left = 250.000
					tc.right = 295.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '800'
					tc.font = 0x60120000
					tc.align = 6
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
				tp = tp.parent
				--end
				tc = G.Entity()
				tp.addChild(tc)
				tc.name = '选项11'
				tc.left = -153.500
				tc.right = 146.500
				tc.bottom = -86.000
				tc.top = -66.000
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
					tc.name = '名称'
					tc.pivotX = 0.000
					tc.left = 4.000
					tc.right = 94.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '药王神篇'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '介绍'
					tc.pivotX = 0.000
					tc.left = 95.000
					tc.right = 260.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '医疗秘籍'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '售价'
					tc.pivotX = 0.000
					tc.left = 250.000
					tc.right = 295.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '200'
					tc.font = 0x60120000
					tc.align = 6
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
				tp = tp.parent
				--end
				tc = G.Entity()
				tp.addChild(tc)
				tc.name = '选项111'
				tc.left = -153.500
				tc.right = 146.500
				tc.bottom = -108.000
				tc.top = -88.000
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
					tc.name = '名称'
					tc.pivotX = 0.000
					tc.left = 4.000
					tc.right = 94.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '药王神篇'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '介绍'
					tc.pivotX = 0.000
					tc.left = 95.000
					tc.right = 260.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '医疗秘籍'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '售价'
					tc.pivotX = 0.000
					tc.left = 250.000
					tc.right = 295.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '200'
					tc.font = 0x60120000
					tc.align = 6
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
				tp = tp.parent
				--end
				tc = G.Entity()
				tp.addChild(tc)
				tc.name = '选项111'
				tc.left = -153.500
				tc.right = 146.500
				tc.bottom = -130.000
				tc.top = -110.000
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
					tc.name = '名称'
					tc.pivotX = 0.000
					tc.left = 4.000
					tc.right = 94.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '药王神篇'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '介绍'
					tc.pivotX = 0.000
					tc.left = 95.000
					tc.right = 260.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '医疗秘籍'
					tc.font = 0x60120000
					tc.align = 4
					tc.wordSpace = -1
					tc.style = 2
					tp = tc
					tp = tp.parent
					--end
					tc = G.TextQuad()
					tp.addChild(tc)
					tc.name = '售价'
					tc.pivotX = 0.000
					tc.left = 250.000
					tc.right = 295.000
					tc.top = 0.000
					tc.anchor = 0x64000000
					tc.text = '200'
					tc.font = 0x60120000
					tc.align = 6
					tc.wordSpace = -1
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
				tc.bottom = -2.783
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
		tc.name = '离开'
		tc.left = -141.000
		tc.right = -101.000
		tc.bottom = -85.000
		tc.top = -65.000
		tc.mouseEnabled = true
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '背景'
			tc.right = 0.000
			tc.top = 0.000
			tc.anchor = 0x64006400
			tc.visible = false
			tc.color = 0xe08080
			tc.alpha = 128
			tc.img = 0x56000001
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '文本'
			tc.left = -40.000
			tc.right = 40.000
			tc.bottom = -20.000
			tc.top = 20.000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '离开'
			tc.font = 0x60240000
			tc.style = 2
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '标签'
		tc.left = -40.000
		tc.right = 140.000
		tc.bottom = -95.000
		tc.top = -55.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '所剩银两：'
		tc.font = 0x60240000
		tc.align = 4
		tc.style = 2
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '银两'
		tc.left = 63.000
		tc.right = 183.000
		tc.bottom = -95.000
		tc.top = -55.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '88888'
		tc.font = 0x60240000
		tc.align = 4
		tc.style = 4
		tp = tc
		tp = tp.parent
		--end
		tc = G.Entity()
		tp.addChild(tc)
		tc.name = '选项模板'
		tc.left = -151.500
		tc.right = 148.500
		tc.bottom = -21.500
		tc.top = -1.500
		tc.anchor = 0x64643232
		tc.mouseEnabled = true
		tc.visible = false
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '背景'
			tc.right = 0.000
			tc.top = 0.000
			tc.anchor = 0x64006400
			tc.visible = false
			tc.color = 0xe08080
			tc.alpha = 128
			tc.img = 0x56000001
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '名称'
			tc.pivotX = 0.000
			tc.right = 180.000
			tc.bottom = -20.000
			tc.top = 20.000
			tc.anchor = 0x32320000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.text = '名称'
			tc.font = 0x60240000
			tc.align = 4
			tc.wordSpace = -1
			tc.style = 2
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '介绍'
			tc.pivotX = 0.000
			tc.left = 95.000
			tc.right = 425.000
			tc.bottom = -20.000
			tc.top = 20.000
			tc.anchor = 0x32320000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.text = '介绍'
			tc.font = 0x60240000
			tc.align = 4
			tc.wordSpace = -1
			tc.style = 2
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '售价'
			tc.pivotX = 0.000
			tc.left = 250.000
			tc.right = 340.000
			tc.bottom = -20.000
			tc.top = 20.000
			tc.anchor = 0x32320000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.text = '售价'
			tc.font = 0x60240000
			tc.align = 6
			tc.wordSpace = -1
			tc.style = 2
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
	tp = tp.parent
	--end
tp.c_grocery = setmetatable({}, c_grocery)
