--[[2002

]]
local G = require 'gf'
local c_button = require 'c_button'
local c_handle_click = require 'c_handle_click'
local c_mainpanel_save = require 'c_mainpanel_save'
local c_mainpanel = require 'c_mainpanel'
local c_shadow = require 'c_shadow'
local c_mainpanel_item = require 'c_mainpanel_item'
local c_mainpanel_item_scripture = require 'c_mainpanel_item_scripture'
local c_mainpanel_role = require 'c_mainpanel_role'
local c_mainpanel_kungfu = require 'c_mainpanel_kungfu'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_mainpanel'
tc.left = -300.000
tc.right = 300.000
tc.bottom = -240.000
tc.top = 240.000
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '透明遮挡'
	tc.right = 0.000
	tc.top = 0.000
	tc.anchor = 0x64006400
	tc.mouseEnabled = true
	tc.visible = false
	tc.alpha = 0
	tc.img = 0x56000001
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '人物界面'
	tc.left = -99.500
	tc.right = 99.500
	tc.bottom = -136.000
	tc.top = 136.000
	tc.visible = false
	tc.autosize = 3
	tc.shadowX = 1
	tc.shadowY = 1
	tc.shadowAlpha = 192
	tc.img = 0x56010043
	tp = tc
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '姓名'
		tc.left = -173.000
		tc.right = 83.000
		tc.bottom = 91.000
		tc.top = 139.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '张三李四'
		tc.font = 0x63280000
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '门派'
		tc.left = -128.000
		tc.right = 22.000
		tc.bottom = 70.000
		tc.top = 108.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '华山派'
		tc.font = 0x63240000
		tc.style = 2
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '称号'
		tc.left = -69.000
		tc.right = 131.000
		tc.bottom = 70.000
		tc.top = 108.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '江湖小虾米'
		tc.font = 0x63240000
		tc.style = 2
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '等级'
		tc.left = 23.000
		tc.right = 71.000
		tc.bottom = 94.000
		tc.top = 134.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '50'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '生命'
		tc.left = -67.000
		tc.right = 29.000
		tc.bottom = 34.000
		tc.top = 74.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '9999'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '生命上限'
		tc.left = -8.000
		tc.right = 88.000
		tc.bottom = 34.000
		tc.top = 74.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '9999'
		tc.font = 0x60240000
		tc.align = 4
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '内力'
		tc.left = -67.000
		tc.right = 29.000
		tc.bottom = 17.000
		tc.top = 57.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '999'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '内力上限'
		tc.left = -8.000
		tc.right = 88.000
		tc.bottom = 17.000
		tc.top = 57.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '999'
		tc.font = 0x60240000
		tc.align = 4
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '福缘'
		tc.left = -80.000
		tc.right = 16.000
		tc.bottom = -5.000
		tc.top = 35.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '100'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '悟性'
		tc.left = -80.000
		tc.right = 16.000
		tc.bottom = -25.400
		tc.top = 14.600
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '50'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '护体'
		tc.left = -80.000
		tc.right = 16.000
		tc.bottom = -43.800
		tc.top = -3.800
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '50'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '拳掌'
		tc.left = -80.000
		tc.right = 16.000
		tc.bottom = -63.200
		tc.top = -23.200
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '50'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '暗器'
		tc.left = -80.000
		tc.right = 16.000
		tc.bottom = -82.600
		tc.top = -42.600
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '50'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '用毒'
		tc.left = -80.000
		tc.right = 16.000
		tc.bottom = -102.000
		tc.top = -62.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '50'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '声望'
		tc.left = -6.000
		tc.right = 90.000
		tc.bottom = -5.000
		tc.top = 35.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '100'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '力道'
		tc.left = -6.000
		tc.right = 90.000
		tc.bottom = -24.400
		tc.top = 15.600
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '50'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '身法'
		tc.left = -6.000
		tc.right = 90.000
		tc.bottom = -43.800
		tc.top = -3.800
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '50'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '御剑'
		tc.left = -6.000
		tc.right = 90.000
		tc.bottom = -63.200
		tc.top = -23.200
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '50'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '医疗'
		tc.left = -6.000
		tc.right = 90.000
		tc.bottom = -82.600
		tc.top = -42.600
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '50'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '解毒'
		tc.left = -6.000
		tc.right = 90.000
		tc.bottom = -102.000
		tc.top = -62.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '50'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '银两'
		tc.left = -56.000
		tc.right = 40.000
		tc.bottom = -139.000
		tc.top = -99.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '9999'
		tc.font = 0x60240000
		tc.align = 6
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '关闭'
		tc.left = 78.000
		tc.right = 96.000
		tc.bottom = 119.000
		tc.top = 133.000
		tc.mouseEnabled = true
		tc.alpha = 0
		tc.img = 0x56000001
		tp = tc
		tp = tp.parent
		--end
	tp.c_mainpanel_role = setmetatable({}, c_mainpanel_role)
	tp.c_shadow = setmetatable({}, c_shadow)
	com = tp.c_shadow
	com['阴影偏移X'] =1.000
	com['阴影偏移Y'] =1.000
	com['阴影透明度'] =192.000
	com['阴影风格'] =nil
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '武功界面'
	tc.left = -109.500
	tc.right = 109.500
	tc.bottom = -147.500
	tc.top = 147.500
	tc.visible = false
	tc.autosize = 3
	tc.shadowX = 1
	tc.shadowY = 1
	tc.shadowAlpha = 192
	tc.img = 0x56010044
	tp = tc
		tc = G.Layout()
		tp.addChild(tc)
		tc.name = '列表'
		tc.left = -98.000
		tc.right = 98.000
		tc.bottom = -129.000
		tc.top = 107.000
		tc.layoutMode = 1
		tc.spacing = 3.800
		tp = tc
			tc = G.Entity()
			tp.addChild(tc)
			tc.name = '武功1'
			tc.left = -98.000
			tc.right = 98.000
			tc.bottom = 82.000
			tc.top = 118.000
			tc.mouseEnabled = true
			tp = tc
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '图标'
				tc.pivotX = 0.000
				tc.right = 36.000
				tc.bottom = -18.000
				tc.top = 18.000
				tc.anchor = 0x32320000
				tc.img = 0x5601100d
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.pivotX = 0.000
				tc.left = 38.000
				tc.right = 302.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32320000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '封魔闷烧波'
				tc.font = 0x63340000
				tc.align = 4
				tc.wordSpace = -1
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '等级'
				tc.pivotX = 1.000
				tc.left = -76.000
				tc.right = -4.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32326464
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '10'
				tc.font = 0x63340000
				tc.align = 6
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
			tc = G.Entity()
			tp.addChild(tc)
			tc.name = '武功2'
			tc.left = -98.000
			tc.right = 98.000
			tc.bottom = 42.200
			tc.top = 78.200
			tc.mouseEnabled = true
			tp = tc
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '图标'
				tc.pivotX = 0.000
				tc.right = 36.000
				tc.bottom = -18.000
				tc.top = 18.000
				tc.anchor = 0x32320000
				tc.img = 0x5601100d
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.pivotX = 0.000
				tc.left = 38.000
				tc.right = 302.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32320000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '封魔闷烧波'
				tc.font = 0x63340000
				tc.align = 4
				tc.wordSpace = -1
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '等级'
				tc.pivotX = 1.000
				tc.left = -76.000
				tc.right = -4.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32326464
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '10'
				tc.font = 0x63340000
				tc.align = 6
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
			tc = G.Entity()
			tp.addChild(tc)
			tc.name = '武功3'
			tc.left = -98.000
			tc.right = 98.000
			tc.bottom = 2.400
			tc.top = 38.400
			tc.mouseEnabled = true
			tp = tc
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '图标'
				tc.pivotX = 0.000
				tc.right = 36.000
				tc.bottom = -18.000
				tc.top = 18.000
				tc.anchor = 0x32320000
				tc.img = 0x5601100d
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.pivotX = 0.000
				tc.left = 38.000
				tc.right = 302.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32320000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '封魔闷烧波'
				tc.font = 0x63340000
				tc.align = 4
				tc.wordSpace = -1
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '等级'
				tc.pivotX = 1.000
				tc.left = -76.000
				tc.right = -4.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32326464
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '10'
				tc.font = 0x63340000
				tc.align = 6
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
			tc = G.Entity()
			tp.addChild(tc)
			tc.name = '武功4'
			tc.left = -98.000
			tc.right = 98.000
			tc.bottom = -37.400
			tc.top = -1.400
			tc.mouseEnabled = true
			tp = tc
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '图标'
				tc.pivotX = 0.000
				tc.right = 36.000
				tc.bottom = -18.000
				tc.top = 18.000
				tc.anchor = 0x32320000
				tc.img = 0x5601100d
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.pivotX = 0.000
				tc.left = 38.000
				tc.right = 302.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32320000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '封魔闷烧波'
				tc.font = 0x63340000
				tc.align = 4
				tc.wordSpace = -1
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '等级'
				tc.pivotX = 1.000
				tc.left = -76.000
				tc.right = -4.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32326464
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '10'
				tc.font = 0x63340000
				tc.align = 6
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
			tc = G.Entity()
			tp.addChild(tc)
			tc.name = '武功5'
			tc.left = -98.000
			tc.right = 98.000
			tc.bottom = -77.200
			tc.top = -41.200
			tc.mouseEnabled = true
			tp = tc
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '图标'
				tc.pivotX = 0.000
				tc.right = 36.000
				tc.bottom = -18.000
				tc.top = 18.000
				tc.anchor = 0x32320000
				tc.img = 0x5601100d
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.pivotX = 0.000
				tc.left = 38.000
				tc.right = 302.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32320000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '封魔闷烧波'
				tc.font = 0x63340000
				tc.align = 4
				tc.wordSpace = -1
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '等级'
				tc.pivotX = 1.000
				tc.left = -76.000
				tc.right = -4.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32326464
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '10'
				tc.font = 0x63340000
				tc.align = 6
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
			tc = G.Entity()
			tp.addChild(tc)
			tc.name = '武功6'
			tc.left = -98.000
			tc.right = 98.000
			tc.bottom = -117.000
			tc.top = -81.000
			tc.mouseEnabled = true
			tp = tc
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '图标'
				tc.pivotX = 0.000
				tc.right = 36.000
				tc.bottom = -18.000
				tc.top = 18.000
				tc.anchor = 0x32320000
				tc.img = 0x5601100d
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.pivotX = 0.000
				tc.left = 38.000
				tc.right = 302.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32320000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '封魔闷烧波'
				tc.font = 0x63340000
				tc.align = 4
				tc.wordSpace = -1
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '等级'
				tc.pivotX = 1.000
				tc.left = -76.000
				tc.right = -4.000
				tc.bottom = -36.000
				tc.top = 36.000
				tc.anchor = 0x32326464
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 255
				tc.text = '10'
				tc.font = 0x63340000
				tc.align = 6
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '拳'
		tc.left = -105.500
		tc.right = -66.500
		tc.bottom = 125.000
		tc.top = 147.000
		tc.mouseEnabled = true
		tc.alpha = 0
		tc.img = 0x56000001
		tp = tc
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='武功_拳'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '掌'
		tc.left = -66.500
		tc.right = -27.500
		tc.bottom = 125.000
		tc.top = 147.000
		tc.mouseEnabled = true
		tc.alpha = 0
		tc.img = 0x56000001
		tp = tc
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='武功_掌'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '指'
		tc.left = -27.500
		tc.right = 11.500
		tc.bottom = 125.000
		tc.top = 147.000
		tc.mouseEnabled = true
		tc.alpha = 0
		tc.img = 0x56000001
		tp = tc
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='武功_指'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '剑'
		tc.left = 11.500
		tc.right = 50.500
		tc.bottom = 125.000
		tc.top = 147.000
		tc.mouseEnabled = true
		tc.alpha = 0
		tc.img = 0x56000001
		tp = tc
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='武功_剑'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '内'
		tc.left = 50.500
		tc.right = 89.500
		tc.bottom = 125.000
		tc.top = 147.000
		tc.mouseEnabled = true
		tc.alpha = 0
		tc.img = 0x56000001
		tp = tc
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='武功_内'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '关闭'
		tc.left = 88.000
		tc.right = 106.000
		tc.bottom = 130.000
		tc.top = 144.000
		tc.mouseEnabled = true
		tc.alpha = 0
		tc.img = 0x56000001
		tp = tc
		tp = tp.parent
		--end
	tp.c_shadow = setmetatable({}, c_shadow)
	com = tp.c_shadow
	com['阴影偏移X'] =1.000
	com['阴影偏移Y'] =1.000
	com['阴影透明度'] =192.000
	com['阴影风格'] =nil
	tp.c_mainpanel_kungfu = setmetatable({}, c_mainpanel_kungfu)
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '物品界面'
	tc.left = -105.000
	tc.right = 105.000
	tc.bottom = -145.500
	tc.top = 145.500
	tc.autosize = 3
	tc.shadowX = 1
	tc.shadowY = 1
	tc.shadowAlpha = 192
	tc.img = 0x56010046
	tp = tc
		tc = G.Layout()
		tp.addChild(tc)
		tc.name = '网格'
		tc.pivotX = 0.000
		tc.pivotY = 1.000
		tc.left = -102.500
		tc.right = 92.500
		tc.bottom = -120.000
		tc.top = 92.000
		tc.layoutMode = 2
		tc.padLeft = 12.000
		tc.spacing = 11.300
		tc.cellX = 36.000
		tc.cellY = 36.000
		tc.lineSpace = 21.000
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品1'
			tc.left = 12.000
			tc.right = 48.000
			tc.bottom = -36.000
			tc.top = 0.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品2'
			tc.left = 59.300
			tc.right = 95.300
			tc.bottom = -36.000
			tc.top = 0.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品3'
			tc.left = 106.600
			tc.right = 142.600
			tc.bottom = -36.000
			tc.top = 0.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品4'
			tc.left = 153.900
			tc.right = 189.900
			tc.bottom = -36.000
			tc.top = 0.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品5'
			tc.left = 12.000
			tc.right = 48.000
			tc.bottom = -93.000
			tc.top = -57.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品6'
			tc.left = 59.300
			tc.right = 95.300
			tc.bottom = -93.000
			tc.top = -57.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品7'
			tc.left = 106.600
			tc.right = 142.600
			tc.bottom = -93.000
			tc.top = -57.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品8'
			tc.left = 153.900
			tc.right = 189.900
			tc.bottom = -93.000
			tc.top = -57.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品9'
			tc.left = 12.000
			tc.right = 48.000
			tc.bottom = -150.000
			tc.top = -114.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品10'
			tc.left = 59.300
			tc.right = 95.300
			tc.bottom = -150.000
			tc.top = -114.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品11'
			tc.left = 106.600
			tc.right = 142.600
			tc.bottom = -150.000
			tc.top = -114.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品12'
			tc.left = 153.900
			tc.right = 189.900
			tc.bottom = -150.000
			tc.top = -114.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品13'
			tc.left = 12.000
			tc.right = 48.000
			tc.bottom = -207.000
			tc.top = -171.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品14'
			tc.left = 59.300
			tc.right = 95.300
			tc.bottom = -207.000
			tc.top = -171.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品15'
			tc.left = 106.600
			tc.right = 142.600
			tc.bottom = -207.000
			tc.top = -171.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品16'
			tc.left = 153.900
			tc.right = 189.900
			tc.bottom = -207.000
			tc.top = -171.000
			tc.anchor = 0x64640000
			tc.mouseEnabled = true
			tc.img = 0x56030001
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -80.000
				tc.right = 80.000
				tc.bottom = -45.000
				tc.top = -13.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '雄蛇丸'
				tc.font = 0x60200000
				tc.wordSpace = -3
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -16.000
				tc.right = 32.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tc.style = 3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '说明'
		tc.left = -160.000
		tc.right = 160.000
		tc.bottom = 84.000
		tc.top = 120.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '点击图片进行装备'
		tc.font = 0x60200000
		tc.align = 4
		tc.style = 4
		tp = tc
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '卸兵'
		tc.left = -15.000
		tc.right = 57.000
		tc.bottom = -131.000
		tc.top = -59.000
		tc.mouseEnabled = true
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '卸兵'
		tc.font = 0x60240000
		tc.align = 4
		tc.style = 4
		tp = tc
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='物品_卸兵'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '卸甲'
		tc.left = 32.000
		tc.right = 104.000
		tc.bottom = -131.000
		tc.top = -59.000
		tc.mouseEnabled = true
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '卸甲'
		tc.font = 0x60240000
		tc.align = 4
		tc.style = 4
		tp = tc
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='物品_卸甲'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '装备'
		tc.left = -101.000
		tc.right = -41.000
		tc.bottom = 121.500
		tc.top = 144.500
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
			tc.text = '装备'
			tc.font = 0x60240000
			tc.wordSpace = 8
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='装备'
		com['customsize'] =true
		com['img_normal'] =1442906193.000
		com['img_hover'] =1442906194.000
		com['img_press'] =1442906195.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='物品_装备'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '丹药'
		tc.left = -39.000
		tc.right = 21.000
		tc.bottom = 121.000
		tc.top = 145.000
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
			tc.text = '丹药'
			tc.font = 0x60240000
			tc.wordSpace = 8
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='丹药'
		com['customsize'] =true
		com['img_normal'] =1442906193.000
		com['img_hover'] =1442906194.000
		com['img_press'] =1442906195.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='物品_丹药'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '事件'
		tc.left = 23.000
		tc.right = 83.000
		tc.bottom = 121.000
		tc.top = 145.000
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
			tc.text = '事件'
			tc.font = 0x60240000
			tc.wordSpace = 8
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='事件'
		com['customsize'] =true
		com['img_normal'] =1442906193.000
		com['img_hover'] =1442906194.000
		com['img_press'] =1442906195.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='通用_UI交互'
		com['事件参数一'] ='物品_事件'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '关闭'
		tc.left = 85.000
		tc.right = 103.000
		tc.bottom = 126.000
		tc.top = 140.000
		tc.mouseEnabled = true
		tc.alpha = 0
		tc.img = 0x56000001
		tp = tc
		tp = tp.parent
		--end
	tp.c_mainpanel_item = setmetatable({}, c_mainpanel_item)
	tp.c_shadow = setmetatable({}, c_shadow)
	com = tp.c_shadow
	com['阴影偏移X'] =1.000
	com['阴影偏移Y'] =1.000
	com['阴影透明度'] =192.000
	com['阴影风格'] =nil
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '秘籍界面'
	tc.left = -131.500
	tc.right = 131.500
	tc.bottom = -166.000
	tc.top = 166.000
	tc.visible = false
	tc.autosize = 3
	tc.shadowX = 1
	tc.shadowY = 1
	tc.shadowAlpha = 192
	tc.img = 0x56010045
	tp = tc
		tc = G.Layout()
		tp.addChild(tc)
		tc.name = '网格'
		tc.pivotY = 1.000
		tc.left = -120.500
		tc.right = 120.500
		tc.bottom = -121.000
		tc.top = 121.000
		tc.layoutMode = 2
		tc.padLeft = 3.000
		tc.spacing = 25.000
		tc.cellX = 36.000
		tc.cellY = 36.000
		tc.lineSpace = 31.000
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品1'
			tc.left = -117.500
			tc.right = -81.500
			tc.bottom = -36.000
			tc.top = 0.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品2'
			tc.left = -56.500
			tc.right = -20.500
			tc.bottom = -36.000
			tc.top = 0.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品3'
			tc.left = 4.500
			tc.right = 40.500
			tc.bottom = -36.000
			tc.top = 0.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品4'
			tc.left = 65.500
			tc.right = 101.500
			tc.bottom = -36.000
			tc.top = 0.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品5'
			tc.left = -117.500
			tc.right = -81.500
			tc.bottom = -103.000
			tc.top = -67.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品6'
			tc.left = -56.500
			tc.right = -20.500
			tc.bottom = -103.000
			tc.top = -67.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品7'
			tc.left = 4.500
			tc.right = 40.500
			tc.bottom = -103.000
			tc.top = -67.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品8'
			tc.left = 65.500
			tc.right = 101.500
			tc.bottom = -103.000
			tc.top = -67.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品9'
			tc.left = -117.500
			tc.right = -81.500
			tc.bottom = -170.000
			tc.top = -134.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品10'
			tc.left = -56.500
			tc.right = -20.500
			tc.bottom = -170.000
			tc.top = -134.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品11'
			tc.left = 4.500
			tc.right = 40.500
			tc.bottom = -170.000
			tc.top = -134.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品12'
			tc.left = 65.500
			tc.right = 101.500
			tc.bottom = -170.000
			tc.top = -134.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品13'
			tc.left = -117.500
			tc.right = -81.500
			tc.bottom = -237.000
			tc.top = -201.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品14'
			tc.left = -56.500
			tc.right = -20.500
			tc.bottom = -237.000
			tc.top = -201.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品15'
			tc.left = 4.500
			tc.right = 40.500
			tc.bottom = -237.000
			tc.top = -201.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '物品16'
			tc.left = 65.500
			tc.right = 101.500
			tc.bottom = -237.000
			tc.top = -201.000
			tc.anchor = 0x64643232
			tc.mouseEnabled = true
			tc.img = 0x56030041
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '名称'
				tc.left = -72.000
				tc.right = 88.000
				tc.bottom = -50.000
				tc.top = -18.000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '吐纳心法'
				tc.font = 0x60200000
				tc.wordSpace = -2
				tc.style = 2
				tp = tc
				tp = tp.parent
				--end
				tc = G.Quad()
				tp.addChild(tc)
				tc.name = '层数'
				tc.left = 18.000
				tc.right = 34.000
				tc.bottom = -18.000
				tc.top = 10.000
				tc.img = 0x56010085
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='通用_UI交互'
			com['事件参数一'] ='使用物品'
			com['事件参数二'] ='-'
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '学点'
		tc.left = -6.000
		tc.right = 42.000
		tc.bottom = -171.000
		tc.top = -133.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '4'
		tc.font = 0x60240000
		tc.align = 6
		tc.style = 4
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '关闭'
		tc.left = 106.500
		tc.right = 127.500
		tc.bottom = 146.000
		tc.top = 162.000
		tc.mouseEnabled = true
		tc.alpha = 0
		tc.img = 0x56000001
		tp = tc
		tp = tp.parent
		--end
	tp.c_shadow = setmetatable({}, c_shadow)
	com = tp.c_shadow
	com['阴影偏移X'] =1.000
	com['阴影偏移Y'] =1.000
	com['阴影透明度'] =192.000
	com['阴影风格'] =nil
	tp.c_mainpanel_item_scripture = setmetatable({}, c_mainpanel_item_scripture)
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '存档界面'
	tc.left = -120.000
	tc.right = 120.000
	tc.bottom = -138.000
	tc.top = 138.000
	tc.visible = false
	tc.img = 0x56010012
	tp = tc
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '标题'
		tc.left = -128.000
		tc.right = 128.000
		tc.bottom = 92.000
		tc.top = 140.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '读取记录'
		tc.font = 0x61300000
		tc.style = 2
		tp = tc
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '取消'
		tc.left = -32.000
		tc.right = 32.000
		tc.bottom = -128.000
		tc.top = -104.000
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
			tc.text = '取消'
			tc.font = 0x60240000
			tc.wordSpace = 8
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['text'] ='取消'
		com['customsize'] =true
		com['img_normal'] =1442906193.000
		com['img_hover'] =1442906194.000
		com['img_press'] =1442906195.000
		tp = tp.parent
		--end
		tc = G.Entity()
		tp.addChild(tc)
		tc.name = '存档一'
		tc.left = -100.000
		tc.right = 98.000
		tc.bottom = 38.000
		tc.top = 96.000
		tc.mouseEnabled = true
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '背景'
			tc.right = 0.000
			tc.top = 0.000
			tc.anchor = 0x64006400
			tc.visible = false
			tc.color = 0xc9b5c4
			tc.img = 0x56000001
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '信息'
			tc.pivotX = 0.000
			tc.left = 8.000
			tc.right = 368.000
			tc.bottom = -38.000
			tc.top = 38.000
			tc.anchor = 0x32320000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '记录一  50 级 日月教[br]2019.01.24  16:27'
			tc.font = 0x61240000
			tc.align = 4
			tc.lineSpace = 4
			tc.style = 2
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.Entity()
		tp.addChild(tc)
		tc.name = '存档二'
		tc.left = -100.000
		tc.right = 98.000
		tc.bottom = -29.000
		tc.top = 29.000
		tc.mouseEnabled = true
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '背景'
			tc.right = 0.000
			tc.top = 0.000
			tc.anchor = 0x64006400
			tc.visible = false
			tc.color = 0xc9b5c4
			tc.img = 0x56000001
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '信息'
			tc.pivotX = 0.000
			tc.left = 8.000
			tc.right = 368.000
			tc.bottom = -38.000
			tc.top = 38.000
			tc.anchor = 0x32320000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '记录一  50 级 日月教[br]2019.01.24  16:27'
			tc.font = 0x61240000
			tc.align = 4
			tc.lineSpace = 4
			tc.style = 2
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.Entity()
		tp.addChild(tc)
		tc.name = '存档三'
		tc.left = -100.000
		tc.right = 98.000
		tc.bottom = -97.000
		tc.top = -39.000
		tc.mouseEnabled = true
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '背景'
			tc.right = 0.000
			tc.top = 0.000
			tc.anchor = 0x64006400
			tc.visible = false
			tc.color = 0xc9b5c4
			tc.img = 0x56000001
			tp = tc
			tp = tp.parent
			--end
			tc = G.TextQuad()
			tp.addChild(tc)
			tc.name = '信息'
			tc.pivotX = 0.000
			tc.left = 8.000
			tc.right = 368.000
			tc.bottom = -38.000
			tc.top = 38.000
			tc.anchor = 0x32320000
			tc.scaleX = 0.500
			tc.scaleY = 0.500
			tc.autosize = 3
			tc.shadowX = 1
			tc.shadowAlpha = 192
			tc.text = '记录一  50 级 日月教[br]2019.01.24  16:27'
			tc.font = 0x61240000
			tc.align = 4
			tc.lineSpace = 4
			tc.style = 2
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
	tp.c_mainpanel_save = setmetatable({}, c_mainpanel_save)
	tp = tp.parent
	--end
tp.c_mainpanel = setmetatable({}, c_mainpanel)
