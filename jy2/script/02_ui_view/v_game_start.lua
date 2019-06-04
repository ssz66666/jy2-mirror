--[[2008

]]
local G = require 'gf'
local c_scrollview = require 'c_scrollview'
local c_button = require 'c_button'
local c_game_start = require 'c_game_start'
local c_handle_click = require 'c_handle_click'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_game_start'
tc.left = -300.000
tc.right = 300.000
tc.bottom = -240.000
tc.top = 240.000
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '背景'
	tc.left = -380.000
	tc.right = 380.000
	tc.bottom = -248.000
	tc.top = 248.000
	tc.img = 0x56010010
	tp = tc
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '版权信息'
		tc.left = -538.000
		tc.right = 486.000
		tc.bottom = -249.000
		tc.top = -169.000
		tc.visible = false
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '该游戏版权所有 [03]半瓶神仙醋[08]  游戏图片版权归游戏公司所有 [br]未经许可擅自转载违者必究'
		tc.font = 0x60240000
		tc.align = 1
		tc.style = 8
		tp = tc
		tp = tp.parent
		--end
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '标题'
	tc.left = -50.000
	tc.right = 50.000
	tc.bottom = 58.000
	tc.top = 158.000
	tc.img = 0x33000003
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '副标题'
	tc.left = 21.500
	tc.right = 188.500
	tc.bottom = 44.500
	tc.top = 73.500
	tc.img = 0x5601000e
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '目录'
	tc.left = -67.000
	tc.right = 33.000
	tc.bottom = -164.000
	tc.top = -64.000
	tc.img = 0x33000004
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '云左'
	tc.left = -850.000
	tc.right = -350.000
	tc.bottom = 126.000
	tc.top = 226.000
	tc.img = 0x5601000f
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '云右'
	tc.left = 550.000
	tc.right = 1450.000
	tc.bottom = -58.000
	tc.top = 52.000
	tc.img = 0x5601000f
	tp = tc
	tp = tp.parent
	--end
	tc = G.Layout()
	tp.addChild(tc)
	tc.name = '菜单'
	tc.left = -50.000
	tc.right = 50.000
	tc.bottom = -140.000
	tc.top = -40.000
	tc.spacing = 4.000
	tc.align = 5
	tp = tc
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '初入江湖'
		tc.left = -98.000
		tc.right = -52.000
		tc.bottom = -60.000
		tc.top = 60.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.left = -23.000
			tc.right = 23.000
			tc.bottom = -50.500
			tc.top = 50.500
			tc.anchor = 0x32323232
			tc.autosize = 3
			tc.img = 0x56010021
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['customsize'] =true
		com['img_normal'] =1442906145.000
		com['img_hover'] =1442906146.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='初入江湖'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '风起云涌'
		tc.left = -48.000
		tc.right = -2.000
		tc.bottom = -60.000
		tc.top = 60.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.left = -23.000
			tc.right = 23.000
			tc.bottom = -50.500
			tc.top = 50.500
			tc.anchor = 0x32323232
			tc.autosize = 3
			tc.img = 0x56010023
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['customsize'] =true
		com['img_normal'] =1442906147.000
		com['img_hover'] =1442906148.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='风起云涌'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '群英荟萃'
		tc.left = 2.000
		tc.right = 48.000
		tc.bottom = -60.000
		tc.top = 60.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.left = -23.000
			tc.right = 23.000
			tc.bottom = -49.500
			tc.top = 49.500
			tc.anchor = 0x32323232
			tc.autosize = 3
			tc.img = 0x56010025
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['customsize'] =true
		com['img_normal'] =1442906149.000
		com['img_hover'] =1442906150.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='群英荟萃'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '封剑归隐'
		tc.left = 52.000
		tc.right = 98.000
		tc.bottom = -60.000
		tc.top = 60.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.left = -23.000
			tc.right = 23.000
			tc.bottom = -50.500
			tc.top = 50.500
			tc.anchor = 0x32323232
			tc.autosize = 3
			tc.img = 0x56010027
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['customsize'] =true
		com['img_normal'] =1442906151.000
		com['img_hover'] =1442906152.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='封剑归隐'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '调整属性'
	tc.left = -300.000
	tc.right = 300.000
	tc.bottom = -240.000
	tc.top = 240.000
	tc.visible = false
	tc.img = 0x56010011
	tp = tc
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '姓名_姓'
		tc.left = -48.000
		tc.right = 96.000
		tc.bottom = 123.000
		tc.top = 173.000
		tc.mouseEnabled = true
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.readOnly = false
		tc.font = 0x60300000
		tc.align = 4
		tc.alignOffset = 4
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '姓名_名'
		tc.left = -48.000
		tc.right = 96.000
		tc.bottom = 92.000
		tc.top = 142.000
		tc.mouseEnabled = true
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.readOnly = false
		tc.font = 0x60300000
		tc.align = 4
		tc.alignOffset = 4
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '头像'
		tc.left = -155.500
		tc.right = -72.500
		tc.bottom = 77.500
		tc.top = 176.500
		tc.scaleX = -1.000
		tc.img = 0x56020001
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '像框'
			tc.left = -49.500
			tc.right = 49.500
			tc.bottom = -57.500
			tc.top = 57.500
			tc.scaleX = -1.000
			tc.img = 0x56010033
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.Layout()
		tp.addChild(tc)
		tc.name = '属性'
		tc.pivotX = 0.000
		tc.pivotY = 1.000
		tc.left = -124.000
		tc.right = 116.000
		tc.bottom = -158.000
		tc.top = 22.000
		tc.layoutMode = 2
		tc.spacing = 15.000
		tc.cellX = 95.000
		tc.cellY = 40.000
		tc.lineSpace = -13.500
		tp = tc
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '生命'
			tc.right = 95.000
			tc.bottom = -40.000
			tc.top = 0.000
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '内力'
			tc.left = 110.000
			tc.right = 205.000
			tc.bottom = -40.000
			tc.top = 0.000
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '力道'
			tc.right = 95.000
			tc.bottom = -66.500
			tc.top = -26.500
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '护体'
			tc.left = 110.000
			tc.right = 205.000
			tc.bottom = -66.500
			tc.top = -26.500
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '身法'
			tc.right = 95.000
			tc.bottom = -93.000
			tc.top = -53.000
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '医疗'
			tc.left = 110.000
			tc.right = 205.000
			tc.bottom = -93.000
			tc.top = -53.000
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '用毒'
			tc.right = 95.000
			tc.bottom = -119.500
			tc.top = -79.500
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '解毒'
			tc.left = 110.000
			tc.right = 205.000
			tc.bottom = -119.500
			tc.top = -79.500
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '拳掌'
			tc.right = 95.000
			tc.bottom = -146.000
			tc.top = -106.000
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '御剑'
			tc.left = 110.000
			tc.right = 205.000
			tc.bottom = -146.000
			tc.top = -106.000
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '暗器'
			tc.right = 95.000
			tc.bottom = -172.500
			tc.top = -132.500
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '悟性'
			tc.left = 110.000
			tc.right = 205.000
			tc.bottom = -172.500
			tc.top = -132.500
			tc.anchor = 0x64640000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '50'
			tc.font = 0x60240000
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '属性介绍'
		tc.pivotX = 0.000
		tc.pivotY = 1.000
		tc.left = 104.000
		tc.right = 460.000
		tc.bottom = -494.000
		tc.top = 160.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '[03]生命[02] 主角受到伤害时，[br]     生命减少。生命[br]     为0时，战败。[br][03]内力[02] 拥有足够的内力[br]     才能使用更具威[br]     力的招式。[br][03]力道[02] 影响普通攻击造[br]     成的伤害。[br][03]护体[02] 影响受伤害程度[br][03]身法[02] 影响出招速度。[br][03]医疗[02] 用以治病、救人。[br][03]用毒[02] 影响使毒效果。[br][03]解毒[02] 影响解毒效果。[br][03]拳掌[02] 拳掌类的功力。[br][03]御剑[02] 兵器类的功力。[br][03]暗器[02] 使暗器的功力。[br][03]悟性[02] 影响主角修炼武[br]     功的效率。'
		tc.wrap = true
		tc.font = 0x60200000
		tc.align = 1
		tc.lineSpace = 1
		tc.style = 3
		tp = tc
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '选择头像'
		tc.pivotX = 0.000
		tc.pivotY = 1.000
		tc.left = -26.000
		tc.right = 58.000
		tc.bottom = 67.000
		tc.top = 99.000
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
			tc.left = -72.000
			tc.right = 72.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '选择头像'
			tc.font = 0x60240000
			tc.alignOffset = -1
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='选择头像'
		com['customsize'] =true
		com['img_normal'] =1442906193.000
		com['img_hover'] =1442906194.000
		com['img_press'] =1442906195.000
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '随机属性'
		tc.pivotX = 0.000
		tc.pivotY = 1.000
		tc.left = -75.000
		tc.right = -11.000
		tc.bottom = -190.000
		tc.top = -160.000
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x56010054
			tp = tc
			end
			tp = tp.parent
			--end
			tc = tp.getChildByName('text')
			if tc then
			tc.left = -36.000
			tc.right = 36.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.anchor = 0x32323232
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.color = 0xffffff
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '随机'
			tc.font = 0x60240000
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='随机'
		com['customsize'] =true
		com['img_normal'] =1442906196.000
		com['color_normal'] =16777215.000
		com['img_hover'] =1442906196.000
		com['img_press'] =1442906197.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='随机属性'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '确定属性'
		tc.pivotX = 0.000
		tc.pivotY = 1.000
		tc.left = 140.000
		tc.right = 248.000
		tc.bottom = -216.000
		tc.top = -176.000
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
			tc.left = -56.000
			tc.right = 56.000
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
			tc.wordSpace = 16
			tc.alignOffset = -1
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
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '头像列表'
		tc.left = -225.000
		tc.right = 225.000
		tc.bottom = -150.000
		tc.top = 150.000
		tc.mouseEnabled = true
		tc.visible = false
		tc.img = 0x56010038
		tp = tc
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '标题'
			tc.left = -160.000
			tc.right = 160.000
			tc.bottom = 105.000
			tc.top = 155.000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.color = 0xfeffff
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '自选头像'
			tc.font = 0x602a0000
			tc.style = 3
			tp = tc
			tp = tp.parent
			--end
			tc = G.Entity()
			tp.addChild(tc)
			tc.name = '列表'
			tc.pivotY = 1.000
			tc.left = 8.000
			tc.right = -12.000
			tc.bottom = -137.000
			tc.top = 118.000
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
				tc.layoutMode = 2
				tc.padLeft = 1.000
				tc.padTop = -4.000
				tc.spacing = 4.000
				tc.align = 2
				tc.cellX = 67.000
				tc.cellY = 80.000
				tc.lineSpace = 5.000
				tp = tc
					tc = G.Entity()
					tp.addChild(tc)
					tc.name = '选项1'
					tc.left = -210.500
					tc.right = -143.500
					tc.bottom = -84.000
					tc.top = -4.000
					tc.anchor = 0x64643232
					tc.mouseEnabled = true
					tp = tc
						tc = G.Quad()
						tp.addChild(tc)
						tc.name = '背景'
						tc.left = -2.000
						tc.right = 2.000
						tc.bottom = -2.000
						tc.top = 2.000
						tc.anchor = 0x64006400
						tc.visible = false
						tc.color = 0xe08080
						tc.img = 0x56000001
						tp = tc
						tp = tp.parent
						--end
						tc = G.Quad()
						tp.addChild(tc)
						tc.name = '头像'
						tc.right = 0.000
						tc.top = 0.000
						tc.anchor = 0x64006400
						tc.scaleX = -1.000
						tc.color = 0x7f8080
						tc.img = 0x56020001
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
				tc.right = 4.000
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
		tp = tp.parent
		--end
	tp = tp.parent
	--end
tp.c_game_start = setmetatable({}, c_game_start)
