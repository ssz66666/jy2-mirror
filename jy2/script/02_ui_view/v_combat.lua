--[[2005

]]
local G = require 'gf'
local c_perfectsize = require 'c_perfectsize'
local c_combat_role_status = require 'c_combat_role_status'
local c_framelist = require 'c_framelist'
local c_bmpfont = require 'c_bmpfont'
local c_combat_cpanel = require 'c_combat_cpanel'
local c_layout_h = require 'c_layout_h'
local c_handle_click = require 'c_handle_click'
local c_button = require 'c_button'
local c_combat = require 'c_combat'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_combat'
tc.left = -300.000
tc.right = 300.000
tc.bottom = -240.000
tc.top = 240.000
tc.mouseEnabled = true
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '背景'
	tc.right = 0.000
	tc.top = 0.000
	tc.anchor = 0x64006400
	tc.color = 0x0
	tc.sample = 0
	tc.img = 0x56000001
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '战场'
	tc.left = -300.000
	tc.right = 300.000
	tc.bottom = -242.000
	tc.top = 178.000
	tc.img = 0x56061001
	tp = tc
		tc = G.Entity()
		tp.addChild(tc)
		tc.name = 'Cross'
		tc.left = 79.000
		tc.right = 143.000
		tc.bottom = -69.000
		tc.top = -5.000
		tc.visible = false
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = 'H'
			tc.right = 0.000
			tc.bottom = -1.000
			tc.top = 1.000
			tc.anchor = 0x32326400
			tc.img = 0x56000001
			tp = tc
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = 'V'
			tc.left = -1.000
			tc.right = 1.000
			tc.top = 0.000
			tc.anchor = 0x64003232
			tc.img = 0x56000001
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.Entity()
		tp.addChild(tc)
		tc.name = 'Cross1'
		tc.left = -143.000
		tc.right = -79.000
		tc.bottom = 5.000
		tc.top = 69.000
		tc.visible = false
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = 'H'
			tc.right = 0.000
			tc.bottom = -1.000
			tc.top = 1.000
			tc.anchor = 0x32326400
			tc.img = 0x56000001
			tp = tc
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = 'V'
			tc.left = -1.000
			tc.right = 1.000
			tc.top = 0.000
			tc.anchor = 0x64003232
			tc.img = 0x56000001
			tp = tc
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '对手'
		tc.left = -161.000
		tc.right = -61.000
		tc.bottom = -13.000
		tc.top = 87.000
		tc.autosize = 3
		tc.img = 0x33001001
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '我方'
		tc.left = 61.000
		tc.right = 161.000
		tc.bottom = -87.000
		tc.top = 13.000
		tc.autosize = 3
		tc.img = 0x33001001
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '对手特效'
		tc.left = 61.000
		tc.right = 161.000
		tc.bottom = -87.000
		tc.top = 13.000
		tc.visible = false
		tc.autosize = 3
		tc.img = 0x33001002
		tp = tc
		tp.c_framelist = setmetatable({}, c_framelist)
		com = tp.c_framelist
		com['动作编号'] =nil
		com['循环播放'] =false
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '我方特效'
		tc.left = -161.000
		tc.right = -61.000
		tc.bottom = -13.000
		tc.top = 87.000
		tc.visible = false
		tc.autosize = 3
		tc.img = 0x33001002
		tp = tc
		tp.c_framelist = setmetatable({}, c_framelist)
		com = tp.c_framelist
		com['动作编号'] =nil
		com['循环播放'] =nil
		tp = tp.parent
		--end
		tc = G.Entity()
		tp.addChild(tc)
		tc.name = '对手伤害'
		tc.left = 61.000
		tc.right = 161.000
		tc.bottom = -87.000
		tc.top = 13.000
		tp = tc
		tp = tp.parent
		--end
		tc = G.Entity()
		tp.addChild(tc)
		tc.name = '我方伤害'
		tc.left = -160.000
		tc.right = -60.000
		tc.bottom = -13.000
		tc.top = 87.000
		tp = tc
		tp = tp.parent
		--end
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '对手状态'
	tc.pivotX = 0.000
	tc.pivotY = 1.000
	tc.left = -300.000
	tc.right = -162.000
	tc.bottom = 133.000
	tc.top = 240.000
	tc.img = 0x56011035
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '头像'
		tc.left = -39.500
		tc.right = 16.500
		tc.bottom = -34.500
		tc.top = 32.500
		tc.scaleX = -1.000
		tc.autosize = 4
		tc.img = 0x56020003
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '背景'
		tc.pivotX = 0.000
		tc.pivotY = 1.000
		tc.left = 108.000
		tc.right = 289.000
		tc.bottom = -71.000
		tc.top = 0.000
		tc.anchor = 0x64640000
		tc.img = 0x56011036
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '生命条'
			tc.pivotX = 0.000
			tc.left = 2.000
			tc.right = 78.222
			tc.bottom = -7.000
			tc.top = 9.000
			tc.anchor = 0x32320000
			tc.img = 0x56011037
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数值'
				tc.left = -88.000
				tc.right = 264.000
				tc.bottom = -20.000
				tc.top = 18.000
				tc.anchor = 0x32320000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '  453/1046 '
				tc.font = 0x60240000
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '内力条'
			tc.pivotX = 0.000
			tc.left = 2.000
			tc.right = 178.000
			tc.bottom = -31.000
			tc.top = -15.000
			tc.anchor = 0x32320000
			tc.img = 0x56011038
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数值'
				tc.left = -88.000
				tc.right = 264.000
				tc.bottom = -20.000
				tc.top = 18.000
				tc.anchor = 0x32320000
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '  300/200  '
				tc.font = 0x60240000
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
		tp = tp.parent
		--end
	tp.c_combat_role_status = setmetatable({}, c_combat_role_status)
	com = tp.c_combat_role_status
	com['生命'] =nil
	com['生命上限'] =nil
	com['内力'] =nil
	com['内力上限'] =nil
	com['集气比例'] =nil
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '气槽'
	tc.pivotX = 0.000
	tc.left = -178.000
	tc.right = -78.000
	tc.bottom = 152.000
	tc.top = 156.000
	tc.color = 0xff
	tc.img = 0x56000001
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '气槽底板'
	tc.pivotX = 0.000
	tc.left = -179.000
	tc.right = -14.000
	tc.bottom = 151.000
	tc.top = 157.000
	tc.img = 0x56011039
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '我方状态'
	tc.pivotX = 0.000
	tc.pivotY = 1.000
	tc.left = 300.000
	tc.right = 438.000
	tc.bottom = 133.000
	tc.top = 240.000
	tc.scaleX = -1.000
	tc.img = 0x56011035
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '头像'
		tc.left = -39.500
		tc.right = 16.500
		tc.bottom = -34.500
		tc.top = 32.500
		tc.scaleX = -1.000
		tc.autosize = 4
		tc.img = 0x56020001
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '背景'
		tc.pivotX = 0.000
		tc.pivotY = 1.000
		tc.left = 108.000
		tc.right = 289.000
		tc.bottom = -71.000
		tc.top = 0.000
		tc.anchor = 0x64640000
		tc.img = 0x56011036
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '生命条'
			tc.pivotX = 0.000
			tc.left = 2.000
			tc.right = 178.000
			tc.bottom = -7.000
			tc.top = 9.000
			tc.anchor = 0x32320000
			tc.img = 0x56011037
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数值'
				tc.left = -88.000
				tc.right = 264.000
				tc.bottom = -20.000
				tc.top = 18.000
				tc.anchor = 0x32320000
				tc.scaleX = -0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '150/150'
				tc.font = 0x60240000
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '内力条'
			tc.pivotX = 0.000
			tc.left = 2.000
			tc.right = 94.000
			tc.bottom = -31.000
			tc.top = -15.000
			tc.anchor = 0x32320000
			tc.img = 0x56011038
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数值'
				tc.left = -88.000
				tc.right = 264.000
				tc.bottom = -20.000
				tc.top = 18.000
				tc.anchor = 0x32320000
				tc.scaleX = -0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '100/100'
				tc.font = 0x60240000
				tp = tc
				tp = tp.parent
				--end
			tp = tp.parent
			--end
		tp = tp.parent
		--end
	tp.c_combat_role_status = setmetatable({}, c_combat_role_status)
	com = tp.c_combat_role_status
	com['生命'] =nil
	com['生命上限'] =nil
	com['内力'] =nil
	com['内力上限'] =nil
	com['集气比例'] =nil
	tp = tp.parent
	--end
	tc = G.TextQuad()
	tp.addChild(tc)
	tc.name = '武功名称'
	tc.left = -95.000
	tc.right = 369.000
	tc.bottom = 69.000
	tc.top = 213.000
	tc.visible = false
	tc.scaleX = 0.500
	tc.scaleY = 0.500
	tc.shadowX = 1
	tc.shadowAlpha = 192
	tc.text = '西瓜刀法'
	tc.img = 0x5601103a
	tc.font = 0x62320000
	tc.style = 3
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '操作面板'
	tc.pivotX = 0.000
	tc.pivotY = 0.000
	tc.left = -300.000
	tc.right = 94.000
	tc.bottom = -240.000
	tc.top = -64.000
	tc.autosize = 3
	tc.img = 0x5601103b
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '气槽'
		tc.pivotX = 0.000
		tc.left = -148.000
		tc.right = -148.000
		tc.bottom = -85.500
		tc.top = -74.500
		tc.img = 0x5601103c
		tp = tc
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '按钮_查看属性'
		tc.left = -129.500
		tc.right = -94.500
		tc.bottom = 12.500
		tc.top = 47.500
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x56011031
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['img_normal'] =1442910257.000
		com['img_press'] =1442910258.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='战斗_操作面板_查看属性'
		com['事件参数一'] =nil
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '按钮_逃跑'
		tc.left = -182.500
		tc.right = -147.500
		tc.bottom = -51.500
		tc.top = -16.500
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x56011033
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['img_normal'] =1442910259.000
		com['img_press'] =1442910260.000
		com['img_disable'] =1442910288.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='战斗_操作面板_逃跑'
		com['事件参数一'] =nil
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '按钮_切换'
		tc.left = 54.500
		tc.right = 89.500
		tc.bottom = -23.500
		tc.top = 11.500
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601102f
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['img_normal'] =1442910255.000
		com['img_press'] =1442910256.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =true
		com['事件名'] ='战斗_操作面板_切换武功类型'
		com['事件参数一'] ='物品'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.loadUI('v_button')
		tp.addChild(tc)
		tc.name = '按钮_攻击'
		tc.left = 119.500
		tc.right = 154.500
		tc.bottom = -71.500
		tc.top = -36.500
		tp = tc
			tc = tp.getChildByName('img')
			if tc then
			tc.img = 0x5601102d
			tp = tc
			end
			tp = tp.parent
			--end
		com = tp.c_button
		com['img_normal'] =1442910253.000
		com['img_press'] =1442910254.000
		com['img_disable'] =1442910252.000
		tp.c_handle_click = setmetatable({}, c_handle_click)
		com = tp.c_handle_click
		com['允许点击事件'] =false
		com['事件名'] ='战斗_操作面板_选择武功'
		com['事件参数一'] ='0'
		com['事件参数二'] =nil
		tp = tp.parent
		--end
		tc = G.Layout()
		tp.addChild(tc)
		tc.name = '切换武功类型'
		tc.left = -78.500
		tc.right = 50.500
		tc.bottom = -27.500
		tc.top = 5.500
		tc.spacing = 1.000
		tp = tc
			tc = G.loadUI('v_button')
			tp.addChild(tc)
			tc.name = '按钮_拳'
			tc.left = -64.500
			tc.right = -39.500
			tc.bottom = -16.500
			tc.top = 16.500
			tp = tc
				tc = tp.getChildByName('img')
				if tc then
				tc.img = 0x56011003
				tp = tc
				end
				tp = tp.parent
				--end
			com = tp.c_button
			com['img_normal'] =1442910211.000
			com['img_press'] =1442910212.000
			com['img_toggle'] =1442910212.000
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='战斗_操作面板_切换武功类型'
			com['事件参数一'] ='拳'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.loadUI('v_button')
			tp.addChild(tc)
			tc.name = '按钮_掌'
			tc.left = -38.500
			tc.right = -13.500
			tc.bottom = -16.500
			tc.top = 16.500
			tp = tc
				tc = tp.getChildByName('img')
				if tc then
				tc.img = 0x56011005
				tp = tc
				end
				tp = tp.parent
				--end
			com = tp.c_button
			com['img_normal'] =1442910213.000
			com['img_press'] =1442910214.000
			com['img_toggle'] =1442910214.000
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='战斗_操作面板_切换武功类型'
			com['事件参数一'] ='掌'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.loadUI('v_button')
			tp.addChild(tc)
			tc.name = '按钮_指'
			tc.left = -12.500
			tc.right = 12.500
			tc.bottom = -16.500
			tc.top = 16.500
			tp = tc
				tc = tp.getChildByName('img')
				if tc then
				tc.img = 0x56011007
				tp = tc
				end
				tp = tp.parent
				--end
			com = tp.c_button
			com['img_normal'] =1442910215.000
			com['img_press'] =1442910216.000
			com['img_toggle'] =1442910216.000
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='战斗_操作面板_切换武功类型'
			com['事件参数一'] ='指'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.loadUI('v_button')
			tp.addChild(tc)
			tc.name = '按钮_剑'
			tc.left = 13.500
			tc.right = 38.500
			tc.bottom = -16.500
			tc.top = 16.500
			tp = tc
				tc = tp.getChildByName('img')
				if tc then
				tc.img = 0x56011009
				tp = tc
				end
				tp = tp.parent
				--end
			com = tp.c_button
			com['img_normal'] =1442910217.000
			com['img_press'] =1442910218.000
			com['img_toggle'] =1442910218.000
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='战斗_操作面板_切换武功类型'
			com['事件参数一'] ='剑'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.loadUI('v_button')
			tp.addChild(tc)
			tc.name = '按钮_内'
			tc.left = 39.500
			tc.right = 64.500
			tc.bottom = -16.500
			tc.top = 16.500
			tp = tc
				tc = tp.getChildByName('img')
				if tc then
				tc.img = 0x5601100b
				tp = tc
				end
				tp = tp.parent
				--end
			com = tp.c_button
			com['img_normal'] =1442910219.000
			com['img_press'] =1442910220.000
			com['img_toggle'] =1442910220.000
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =true
			com['事件名'] ='战斗_操作面板_切换武功类型'
			com['事件参数一'] ='内'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.Layout()
		tp.addChild(tc)
		tc.name = '选择武功'
		tc.left = -145.000
		tc.right = 111.000
		tc.bottom = -70.000
		tc.top = -34.000
		tc.spacing = 7.000
		tp = tc
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '武功1'
			tc.left = -128.000
			tc.right = -92.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.mouseEnabled = true
			tc.img = 0x5601100d
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -20.000
				tc.right = 28.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.visible = false
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =false
			com['事件名'] ='战斗_操作面板_选择武功'
			com['事件参数一'] ='1'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '武功2'
			tc.left = -85.000
			tc.right = -49.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.mouseEnabled = true
			tc.img = 0x5601100d
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -20.000
				tc.right = 28.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.visible = false
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =false
			com['事件名'] ='战斗_操作面板_选择武功'
			com['事件参数一'] ='2'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '武功3'
			tc.left = -42.000
			tc.right = -6.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.mouseEnabled = true
			tc.img = 0x5601100d
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -20.000
				tc.right = 28.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.visible = false
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =false
			com['事件名'] ='战斗_操作面板_选择武功'
			com['事件参数一'] ='3'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '武功4'
			tc.left = 1.000
			tc.right = 37.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.mouseEnabled = true
			tc.img = 0x5601100d
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -20.000
				tc.right = 28.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.visible = false
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =false
			com['事件名'] ='战斗_操作面板_选择武功'
			com['事件参数一'] ='4'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '武功5'
			tc.left = 44.000
			tc.right = 80.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.mouseEnabled = true
			tc.img = 0x5601100d
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -20.000
				tc.right = 28.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.visible = false
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =false
			com['事件名'] ='战斗_操作面板_选择武功'
			com['事件参数一'] ='5'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
			tc = G.Quad()
			tp.addChild(tc)
			tc.name = '武功6'
			tc.left = 87.000
			tc.right = 123.000
			tc.bottom = -18.000
			tc.top = 18.000
			tc.mouseEnabled = true
			tc.img = 0x5601100d
			tp = tc
				tc = G.TextQuad()
				tp.addChild(tc)
				tc.name = '数量'
				tc.left = -20.000
				tc.right = 28.000
				tc.bottom = -26.000
				tc.top = 6.000
				tc.visible = false
				tc.scaleX = 0.500
				tc.scaleY = 0.500
				tc.shadowX = 1
				tc.shadowAlpha = 192
				tc.text = '10'
				tc.font = 0x60200000
				tc.align = 6
				tc.wordSpace = -3
				tp = tc
				tp = tp.parent
				--end
			tp.c_handle_click = setmetatable({}, c_handle_click)
			com = tp.c_handle_click
			com['允许点击事件'] =false
			com['事件名'] ='战斗_操作面板_选择武功'
			com['事件参数一'] ='6'
			com['事件参数二'] =nil
			tp = tp.parent
			--end
		tp = tp.parent
		--end
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '武功属性'
		tc.left = 100.000
		tc.right = 500.000
		tc.bottom = -110.000
		tc.top = -10.000
		tc.visible = false
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 255
		tc.text = '测试武功  Lv9 Exp: 45%[br]耗内: 30 集气: 5[br]威力: 400 ~ 500'
		tc.font = 0x60200041
		tc.align = 4
		tp = tc
		tp = tp.parent
		--end
	tp.c_combat_cpanel = setmetatable({}, c_combat_cpanel)
	tp = tp.parent
	--end
	tc = G.loadUI('v_bmpfont')
	tp.addChild(tc)
	tc.name = '伤害数值'
	tc.left = -56.000
	tc.right = 56.000
	tc.visible = false
	tc.color = 0xff
	tp = tc
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '-'
		tc.left = 36.000
		tc.right = 64.000
		tc.bottom = 31.000
		tc.top = 69.000
		tc.anchor = 0x64640000
		tc.img = 0x5607000c
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '6'
		tc.left = 36.000
		tc.right = 64.000
		tc.bottom = 31.000
		tc.top = 69.000
		tc.anchor = 0x64640000
		tc.img = 0x56070006
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '6'
		tc.left = 36.000
		tc.right = 64.000
		tc.bottom = 31.000
		tc.top = 69.000
		tc.anchor = 0x64640000
		tc.img = 0x56070006
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '6'
		tc.left = 36.000
		tc.right = 64.000
		tc.bottom = 31.000
		tc.top = 69.000
		tc.anchor = 0x64640000
		tc.img = 0x56070006
		tp = tc
		tp = tp.parent
		--end
	com = tp.c_layout_h
	com['alignment_h'] =0.000
	com = tp.c_bmpfont
	com['text'] ='-666'
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '战斗对话'
	tc.pivotX = 0.000
	tc.left = -294.000
	tc.right = -91.000
	tc.bottom = 56.500
	tc.top = 131.500
	tc.visible = false
	tc.autosize = 5
	tc.img = 0x56010032
	tp = tc
		tc = G.TextQuad()
		tp.addChild(tc)
		tc.name = '文本'
		tc.left = -136.000
		tc.right = 124.000
		tc.bottom = -80.000
		tc.top = 80.000
		tc.scaleX = 0.500
		tc.scaleY = 0.500
		tc.shadowX = 1
		tc.shadowAlpha = 192
		tc.text = '主角的气槽.发招时的必要条件是要先攒满一定长度的气槽。'
		tc.wrap = true
		tc.font = 0x60240000
		tc.align = 4
		tc.style = 3
		tp = tc
		tp = tp.parent
		--end
		tc = G.Quad()
		tp.addChild(tc)
		tc.name = '等待'
		tc.left = -64.000
		tc.right = -48.000
		tc.top = 16.000
		tc.anchor = 0x6464
		tc.img = 0x33000002
		tp = tc
		tp = tp.parent
		--end
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '圆圈'
	tc.left = 192.000
	tc.right = 240.000
	tc.bottom = -194.000
	tc.top = -146.000
	tc.visible = false
	tc.color = 0xff
	tc.img = 0x56010039
	tp = tc
	tp = tp.parent
	--end
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '战斗结果'
	tc.left = -50.000
	tc.right = 50.000
	tc.bottom = -50.000
	tc.top = 50.000
	tc.visible = false
	tc.img = 0x33000001
	tp = tc
	tp = tp.parent
	--end
tp.c_combat = setmetatable({}, c_combat)
