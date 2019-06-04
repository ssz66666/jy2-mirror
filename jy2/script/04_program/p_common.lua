--[[4003

]]
local G = require "gf"
local t = G.api
local L = {}
--type=通用动画系统
--hide=false
--private=false
--ret=o_common_action
t['通用_图片震动'] = function(int_振幅,number_持续时间)
-->	G.log("逻辑在 .\\script\\05_anim\\a_common.lua 中")
end
--type=通用动画系统
--hide=true
--private=false
--ret=o_common_action
t['通用_图片移动'] = function(o_vector_起始位置,o_vector_结束位置,number_持续时间)
    -->G.log("逻辑在 .\\script\\05_anim\\a_common.lua 中")
end
--type=通用动画系统
--hide=true
--private=false
--ret=o_common_action
t['通用_图片透明度变化'] = function(percent_起始透明度,percent_结束透明度,number_持续时间)
    -->G.log("逻辑在 .\\script\\05_anim\\a_common.lua 中")
end
--type=通用动画系统
--hide=true
--private=false
--ret=o_common_action
t['通用_图片颜色变化'] = function(color_起始颜色,color_结束颜色,number_持续时间)
    -->G.log("逻辑在 .\\script\\05_anim\\a_common.lua 中")
end
--type=通用动画系统
--hide=true
--private=false
--ret=o_common_action
t['通用_图片X轴压缩'] = function(number_起始比例,number_结束比例,number_持续时间)
    -->G.log("逻辑在 .\\script\\05_anim\\a_common.lua 中")
end
--type=通用系统
--hide=true
--private=false
--ret=int
t['通用_获取游戏时间'] = function()
	return os.clock() * 1000;
end
--type=通用系统
--private=false
--ret=int
t['通用_显示开始菜单'] = function()
	
end
--type=通用系统
--private=false
--ret=int
t['通用_关闭开始菜单'] = function()
	
end
--type=通用系统
--private=false
--ret=int
t['通用_显示结束菜单'] = function()
	
end
--type=通用系统
--private=false
--ret=int
t['通用_关闭结束菜单'] = function()
	G.call('场景系统_初始化剧本')
	G.noti_call('场景系统_隐藏')
end
--type=通用系统
--hide=true
--private=false
--ret=boolean
t['通用_退出游戏'] = function()
	os.exit()
end
--type=通用系统
--hide=false
--private=false
--ret=string
t['通用_延时触发事件'] = function(int_延时,string_事件名,string_事件参数1,string_事件参数2,string_事件参数3)
	G.RunAction("通用_延时触发事件", int_延时, string_事件名,string_事件参数1,string_事件参数2,string_事件参数3)
end
--type=通用系统
--hide=true
--private=false
--ret=string
t['通用_处理转意字符'] = function(string_字符串)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	if string_字符串 == nil then
		return
	end
	string_字符串 = string.gsub(string_字符串, "%[姓%]", o_role_主角.姓)
	string_字符串 = string.gsub(string_字符串, "%[名%]", o_role_主角.名)
	string_字符串 = string.gsub(string_字符串, "%[姓名%]", o_role_主角.姓名)
	return string_字符串
end
--type=通用系统
--private=false
t['通用_UI交互响应'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local string_UI名称 = nil
	local string_事件参数 = nil
	local o_role_属性 = nil
	local o_item_物品 = nil
	local _any_事件信息 = nil
	while true do 
		string_UI名称 = G.call("通用_等待事件","通用_UI交互")
		if string_UI名称 == "初入江湖" then 
			G.clearDynamic()
			o_base_游戏数据 = G.QueryName(0x10050001)
			o_role_主角 = o_base_游戏数据.主角
			G.call("通用_重设初始属性")
			G.call("通用_显示调整属性界面",o_role_主角)
		elseif string_UI名称 == "风起云涌" then 
			G.call("通用_显示读档界面")
			string_事件参数 = G.call("通用_等待事件","存档_操作结束")
			if string_事件参数 == "读档" then 
				o_base_游戏数据 = G.QueryName(0x10050001)
				o_role_主角 = o_base_游戏数据.主角
				G.call("通用_关闭开始菜单")
				G.call("通用_停止所有声音")
				if o_base_游戏数据.当前剧本 ~= nil then
					o_base_游戏数据.允许剧本事件 = false
					G.call("场景系统_切换剧本", o_base_游戏数据.当前剧本)
				else
					G.call("场景系统_切换剧本",{n = 0, "剧情_主地图"})
				end
			else 
			end
		elseif string_UI名称 == "群英荟萃" then 
			G.call("通用_显示公告")
		elseif string_UI名称 == "关闭公告" then 
			G.call("通用_关闭公告")
		elseif string_UI名称 == "封剑归隐" then 
			G.call("通用_退出游戏")
		elseif string_UI名称 == "重新开始" then 
			G.call("通用_关闭结束菜单")
			G.call("通用_显示开始菜单")
		elseif string_UI名称 == "更改头像" then 
			_any_事件信息 = G.call("通用_获取事件详细信息")
			if _any_事件信息[3] ~= nil then 
				o_role_主角.头像 = _any_事件信息[3]
			else 
			end
		elseif string_UI名称 == "随机属性" then 
			G.call("通用_重设初始属性")
			G.call("通用_显示调整属性界面",o_role_主角)
		elseif string_UI名称 == "确定属性" then 
			_any_事件信息 = G.call("通用_获取事件详细信息")
			if _any_事件信息[3] ~= nil and _any_事件信息[4] ~= nil and _any_事件信息[3] ~= "" and _any_事件信息[4] ~= "" then 
				o_role_主角.姓 = _any_事件信息[3]
				o_role_主角.名 = _any_事件信息[4]
				o_role_主角.姓名 = o_role_主角.姓 .. o_role_主角.名
				G.call("通用_关闭开始菜单")
				G.call("通用_停止所有声音")
				G.call("场景系统_切换剧本", o_base_游戏数据.当前剧本)
			else 
				G.call("通知系统_显示系统提示并等待确定","请玩家确定姓名不为空！！！","提示！！")
			end
		elseif string_UI名称 == "人物" then 
			G.call("通用_显示人物界面")
		elseif string_UI名称 == "武功" or string_UI名称 == "武功_拳" then 
			G.call("通用_显示武功界面",{G.QueryName(0x10040003), G.QueryName(0x10040004), G.QueryName(0x10040005), G.QueryName(0x10040006), G.QueryName(0x10040007), G.QueryName(0x10040008)})
		elseif string_UI名称 == "武功_掌" then 
			G.call("通用_显示武功界面",{G.QueryName(0x10040009), G.QueryName(0x1004000a), G.QueryName(0x1004000b), G.QueryName(0x1004000c), G.QueryName(0x1004000d), G.QueryName(0x1004000e)})
		elseif string_UI名称 == "武功_指" then 
			G.call("通用_显示武功界面",{G.QueryName(0x1004000f), G.QueryName(0x10040010), G.QueryName(0x10040011), G.QueryName(0x10040012), G.QueryName(0x10040013), G.QueryName(0x10040014)})
		elseif string_UI名称 == "武功_剑" then 
			G.call("通用_显示武功界面",{G.QueryName(0x10040015), G.QueryName(0x10040016), G.QueryName(0x10040017), G.QueryName(0x10040018), G.QueryName(0x10040019), G.QueryName(0x1004001a)})
		elseif string_UI名称 == "武功_内" then 
			G.call("通用_显示武功界面",{G.QueryName(0x1004001b), G.QueryName(0x1004001c), G.QueryName(0x1004001d), G.QueryName(0x1004001e), G.QueryName(0x1004001f), G.QueryName(0x10040020)})
		elseif string_UI名称 == "物品" or string_UI名称 == "物品_装备" then 
			G.call("通用_显示物品界面",0)
		elseif string_UI名称 == "物品_卸兵" then 
			o_role_主角.武器 = nil
			G.call("通用_显示物品界面",0)
		elseif string_UI名称 == "物品_卸甲" then 
			o_role_主角.防具 = nil
			G.call("通用_显示物品界面",0)
		elseif string_UI名称 == "物品_丹药" then 
			G.call("通用_显示物品界面",1)
		elseif string_UI名称 == "物品_事件" then 
			G.call("通用_显示物品界面",2)
		elseif string_UI名称 == "秘籍" then 
			G.call("通用_显示秘籍界面")
		elseif string_UI名称 == "使用物品" then 
			o_item_物品 = G.call("通用_获取使用物品")
			if o_item_物品 ~= nil then 
				G.call("通用_使用物品",o_item_物品)
			else 
			end
		elseif string_UI名称 == "存档" then 
			G.call("通用_显示存档界面")
			G.wait1({"存档_操作结束", nil},nil,nil,nil)
		elseif string_UI名称 == "退出" then 
			if G.call("通知系统_显示系统提示并等待选择","你真的决定退出江湖吗？") then 
				G.call("场景系统_隐藏")
				G.call('场景系统_初始化剧本')
				G.call("通用_显示开始菜单")
			else 
			end
		else 
		end
	end
end
--type=通用系统
--private=false
t['通用_显示主界面'] = function(boolean_显示)

end
--type=通用系统
--private=false
t['通用_关闭所有界面'] = function()
    
end
--type=通用系统
--private=false
t['通用_显示调整属性界面'] = function(o_role_主角)

end
--type=通用系统
--private=false
t['通用_显示公告'] = function()

end
--type=通用系统
--private=false
t['通用_关闭公告'] = function()

end
--type=通用系统
--private=false
t['通用_重设初始属性'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	o_role_主角.生命上限 = G.call('运算_随机数', 30, 60)
	o_role_主角.内力上限 = G.call('运算_随机数', 10, 55)
	o_role_主角.生命上限 = G.call('运算_限制范围', o_role_主角.生命上限, 30, 50)
	o_role_主角.内力上限 = G.call('运算_限制范围', o_role_主角.内力上限,10, 50)
	o_role_主角.生命 = o_role_主角.生命上限
	o_role_主角.内力 = o_role_主角.内力上限
	o_role_主角.力道 = G.call('运算_随机数', 5, 30)
	o_role_主角.护体 = G.call('运算_随机数', 5, 30)
	o_role_主角.身法 = G.call('运算_随机数', 5, 30)
	o_role_主角.拳掌 = G.call('运算_随机数', 5, 30)
	o_role_主角.御剑 = G.call('运算_随机数', 5, 30)
	o_role_主角.暗器 = G.call('运算_随机数', 5, 30)
	o_role_主角.医疗 = G.call('运算_随机数', 5, 30)
	o_role_主角.用毒 = G.call('运算_随机数', 5, 30)
	o_role_主角.解毒 = G.call('运算_随机数', 5, 30)
	o_role_主角.悟性 = G.call('运算_随机数', 10, 100)
	o_role_主角.福缘 = G.call('运算_随机数', 10, 100)
end
--type=通用系统
--private=false
t['通用_显示人物界面'] = function()
    G.call('通用_更新人物装备属性')
end
--type=通用系统
--private=false
t['通用_显示武功界面'] = function(_o_kungfu_武功)
	
end
--type=通用系统
--private=false
--text=<03>【显示物品界面】<00>页面[var:1]
t['通用_显示物品界面'] = function(enum_物品类型_类型)
	
end
--type=通用系统
--private=false
t['通用_显示秘籍界面'] = function()
	
end
--type=通用系统
--private=false
t['通用_更新人物装备属性'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	o_role_主角.力道1 = o_role_主角.力道
	o_role_主角.护体1 = o_role_主角.护体
	o_role_主角.身法1 = o_role_主角.身法
	if o_role_主角.武器 ~= nil then
		if o_role_主角.武器.装备加力道 ~= nil then
			o_role_主角.力道1 = o_role_主角.力道1 + o_role_主角.武器.装备加力道
		end
		if o_role_主角.武器.装备加护体 ~= nil then
			o_role_主角.护体1 = o_role_主角.护体1 + o_role_主角.武器.装备加护体
		end
	end
	if o_role_主角.防具 ~= nil then
		if o_role_主角.防具.装备加力道 ~= nil then
			o_role_主角.力道1 = o_role_主角.力道1 + o_role_主角.防具.装备加力道
		end
		if o_role_主角.防具.装备加护体 ~= nil then
			o_role_主角.护体1 = o_role_主角.护体1 + o_role_主角.防具.装备加护体
		end
	end
end
--type=通用系统
--private=false
--text=<03>【使用物品】<00>[var:1]
t['通用_使用物品'] = function(o_item_物品)
	local o_base_游戏数据 = G.QueryName(0x10050001)
    local o_role_主角 = o_base_游戏数据.主角
	local o_item_effect_效果 = nil
	if o_item_物品 == nil then
		return
	end
	if o_item_物品.数量 <= 0 then
		return
	end
	if o_item_物品.类型 == '武器' then
		o_role_主角.武器 = o_item_物品
		G.call("通用_显示物品界面", 0);
	elseif o_item_物品.类型 == '防具' then
		o_role_主角.防具 = o_item_物品
		G.call("通用_显示物品界面", 0);
	elseif o_item_物品.类型 == '丹药' then
		G.call("通用_变更物品数量", o_item_物品, -1)
		o_item_effect_效果 = o_item_物品.药物效果
		G.call("通用_显示物品界面", 1);
	elseif o_item_物品.类型 == '秘籍' then
		if o_item_物品.修炼层数 == nil then
			o_item_物品.修炼层数 = 0
		end
		if o_item_物品.修炼层数 < 5 then
			if G.call("通用_检查人物属性", "内力上限", o_item_物品.修炼需内力, nil) then
				if G.call("通用_检查人物属性", "学点", 1, nil) then
					G.call("通用_变更人物属性", "学点", "增减", - 1)
					o_item_物品.修炼层数 = o_item_物品.修炼层数 + 1
					if o_item_物品.修炼效果 ~= nil then
						o_item_effect_效果 = o_item_物品.修炼效果[o_item_物品.修炼层数]
					end
					if o_item_物品.修炼层数 == 5 then
						if o_item_物品.练出武功 ~= nil then
							if G.call("通用_检查武功", o_item_物品.练出武功, 1) then
							else
								G.call("通用_学会武功", o_item_物品.练出武功)
								G.call("通知系统_显示飘字","习得 " .. o_item_物品.练出武功.名称,0x4900001a,0xFF,'右上',500)
							end
						else
						end
					else
					end
					G.call("通用_显示秘籍界面");
				else
					G.call("通知系统_显示飘字","修炼点不足",0x49000023,0xFF,'右上',0)
				end
			else
				G.call("通知系统_显示飘字","内功修为不足",0x49000023,0xFF,'右上',0)
			end
		else
		end
	end
	if o_item_effect_效果 ~= nil then
		G.call("通知系统_显示飘字","属性提升",0x4900001a,0xFF,'右上',0)
		if o_item_effect_效果['加生命上限%'] ~= nil and o_item_effect_效果['加生命上限%'] ~= 0 then
			G.call("通用_变更人物属性", "生命上限", "乘以", 1 + o_item_effect_效果['加生命上限%'])
		end
		if o_item_effect_效果['加内力上限%'] ~= nil and o_item_effect_效果['加内力上限%'] ~= 0 then
			G.call("通用_变更人物属性", "内力上限", "乘以", 1 + o_item_effect_效果['加内力上限%'])
		end
		if o_item_effect_效果.加生命上限 ~= nil and o_item_effect_效果.加生命上限 ~= 0 then
			G.call("通用_变更人物属性", "生命上限", "增减", o_item_effect_效果.加生命上限)
		end
		if o_item_effect_效果.加内力上限 ~= nil and o_item_effect_效果.加内力上限 ~= 0 then
			G.call("通用_变更人物属性", "内力上限", "增减", o_item_effect_效果.加内力上限)
		end
		if o_item_effect_效果['加生命%'] ~= nil and o_item_effect_效果['加生命%'] ~= 0 then
			G.call("通用_变更人物属性", "生命", "增减", o_role_主角.生命上限 * o_item_effect_效果['加生命%'])
		end
		if o_item_effect_效果['加内力%'] ~= nil and o_item_effect_效果['加内力%'] ~= 0 then
			G.call("通用_变更人物属性", "内力", "增减", o_role_主角.内力上限 *  o_item_effect_效果['加内力%'])
		end
		if o_item_effect_效果.加力道 ~= nil and o_item_effect_效果.加力道 ~= 0 then
			G.call("通用_变更人物属性", "力道", "增减", o_item_effect_效果.加力道)
		end
		if o_item_effect_效果.加护体 ~= nil and o_item_effect_效果.加护体 ~= 0 then
			G.call("通用_变更人物属性", "护体", "增减", o_item_effect_效果.加护体)
		end
		if o_item_effect_效果.加身法 ~= nil and o_item_effect_效果.加身法 ~= 0 then
			G.call("通用_变更人物属性", "身法", "增减", o_item_effect_效果.加身法)
		end
		if o_item_effect_效果.加拳掌 ~= nil and o_item_effect_效果.加拳掌 ~= 0 then
			G.call("通用_变更人物属性", "拳掌", "增减", o_item_effect_效果.加拳掌)
		end
		if o_item_effect_效果.加御剑 ~= nil and o_item_effect_效果.加御剑 ~= 0 then
			G.call("通用_变更人物属性", "御剑", "增减", o_item_effect_效果.加御剑)
		end
		if o_item_effect_效果.加暗器 ~= nil and o_item_effect_效果.加暗器 ~= 0 then
			G.call("通用_变更人物属性", "暗器", "增减", o_item_effect_效果.加暗器)
		end
		if o_item_effect_效果.加医疗 ~= nil and o_item_effect_效果.加医疗 ~= 0 then
			G.call("通用_变更人物属性", "医疗", "增减", o_item_effect_效果.加医疗)
		end
		if o_item_effect_效果.加解毒 ~= nil and o_item_effect_效果.加解毒 ~= 0 then
			G.call("通用_变更人物属性", "解毒", "增减", o_item_effect_效果.加解毒)
		end
	end
end
--type=对话系统
--hide=true
--private=false
--ret=int
--text=<03>【显示商店】<00>[var:1]
t['通用_显示商店'] = function(_string_商品)
	local o_base_游戏数据 = G.QueryName(0x10050001)
    local o_role_主角 = o_base_游戏数据.主角
    G.call('通用_显示商店界面', o_role_主角.银两, _string_商品)
    return G.call("通用_等待事件", "商店系统_显示商品_结束"); 
end
--type=通用系统
--hide=true
--private=false
--ret=any
t['通用_等待事件'] = function(even_事件名)
	local any_信息1, any_信息2, any_信息3, any_信息4
	G.wait1(even_事件名,nil,nil,nil)
	any_信息1, any_信息2, any_信息3, any_信息4 = G.event_info()
	G.misc().事件信息 = {even_事件名, any_信息1, any_信息2, any_信息3, any_信息4}
	return any_信息1
end
--type=通用系统
--hide=true
--private=false
--ret=any
t['通用_获取事件详细信息'] = function()
	return G.misc().事件信息
end
--type=通用系统
--hide=true
--private=false
--ret=o_item
t['通用_获取使用物品'] = function()
	local _any_事件信息 = G.call("通用_获取事件详细信息");
	local int_物品编号 = 0
	if _any_事件信息[1] == '通用_UI交互' and _any_事件信息[2] == '使用物品' then
		int_物品编号 = tonumber(_any_事件信息[3])
		if int_物品编号 ~= nil and int_物品编号 > 0 then
			return G.QueryName(int_物品编号)
		end
	end
end
--type=通用指令
--hide=false
--private=false
--ret=boolean
--text=检查主角属性<00> [var:1]<06> 处于 <00>[var:2] ~ [var:3]
t['通用_检查人物属性'] = function(estr_可设置属性_属性,int_下限,int_上限)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local int_属性 = o_role_主角[estr_可设置属性_属性];
	
	if int_属性 == nil then
		return false
	end
	if int_下限 ~= nil and int_属性 < int_下限 then
		return false
	end
	if int_上限 ~= nil and int_属性 > int_上限 then
		return false
	end
	return true
end
--type=通用指令
--hide=false
--private=false
--ret=o_common_change_attribute
--text=主角 [var:1] [var:2] [var:3]
t['通用_变更人物属性'] = function(estr_可设置属性_属性,estr_属性设置方式_设置方式,number_数值)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
    local o_role_属性上限 = o_base_游戏数据.属性上限
    local int_属性 = o_role_主角[estr_可设置属性_属性];
	local int_属性上限 = o_role_属性上限[estr_可设置属性_属性];
	if number_数值 == nil then
		return
	end
	if int_属性 == nil then
		int_属性 = 0
	else
	end
	if '增减' == estr_属性设置方式_设置方式 then
		int_属性 = int_属性 + number_数值;
	elseif '乘以' == estr_属性设置方式_设置方式 then
		int_属性 = int_属性 * number_数值;
		if int_属性 < 1 then
			int_属性 = 1
		end
	elseif '设为' == estr_属性设置方式_设置方式 then
		int_属性 = number_数值;
	end
	int_属性 = G.call('运算_向下取整', int_属性);
	if '生命' == estr_可设置属性_属性 then
		int_属性上限 = o_role_主角.生命上限;
	elseif '内力' == estr_可设置属性_属性 then
		int_属性上限 = o_role_主角.内力上限;
	end
	if int_属性上限 and int_属性 > int_属性上限 then
		int_属性 = int_属性上限;
	elseif int_属性 < 0 then
		int_属性 = 0;
    end
	o_role_主角[estr_可设置属性_属性] = int_属性;
	if estr_可设置属性_属性 == '生命' or estr_可设置属性_属性 == '生命上限' or estr_可设置属性_属性 == '内力' or estr_可设置属性_属性 == '内力上限' or estr_可设置属性_属性 == '经验' or estr_可设置属性_属性 == '经验上限' then
		G.call("场景系统_更新主界面", o_role_主角);
	end
end
--type=通用指令
--hide=false
--private=false
--ret=boolean
--text=检查是否拥有物品<00>[var:1]
t['通用_检查物品'] = function(o_item_物品)
	if o_item_物品 then
		return o_item_物品.数量 >= 1;
	else
		return false;
	end
end
--type=通用指令
--hide=false
--private=false
--text=物品<00> [var:1] <06>数量<00>[var:2]
t['通用_变更物品数量'] = function(o_item_物品,int_数量增减)
	local int_数量 = 0;
	if o_item_物品 then
		if o_item_物品.类型 == '暗器' or o_item_物品.类型 == '丹药' then
			int_数量 = o_item_物品.数量 + int_数量增减
			o_item_物品.数量 = int_数量;
		else
			if int_数量增减 > 0 then
				o_item_物品.数量 = 1
			elseif int_数量增减 < 0 then
				o_item_物品.数量 = 0
			end
		end
	end
end
--type=通用指令
--hide=false
--private=false
--ret=boolean
--text=检查武功<00>[var:1] <06>等级达到 <00>[var:2]
t['通用_检查武功'] = function(o_kungfu_武功,int_等级)
	if int_等级 == nil then
		int_等级 = 1;
	end
	if o_kungfu_武功 then
		return o_kungfu_武功.等级 >= int_等级;
	else
		return false;
	end
end
--type=通用指令
--hide=false
--private=false
--text=学会武功<00> [var:1]
t['通用_学会武功'] = function(o_kungfu_武功)
	if o_kungfu_武功 then
		if o_kungfu_武功.等级 == 0 then
			o_kungfu_武功.等级 = 1;
			o_kungfu_武功.经验 = 0;
		end
	end
end
--type=通用指令
--hide=false
--private=false
--text=遗忘所有武功
t['通用_遗忘所有武功'] = function()
	G.QueryName(0x10040003).等级 = 0
	G.QueryName(0x10040003).经验 = 0
	G.QueryName(0x10040004).等级 = 0
	G.QueryName(0x10040004).经验 = 0
	G.QueryName(0x10040005).等级 = 0
	G.QueryName(0x10040005).经验 = 0
	G.QueryName(0x10040006).等级 = 0
	G.QueryName(0x10040006).经验 = 0
	G.QueryName(0x10040007).等级 = 0
	G.QueryName(0x10040007).经验 = 0
	G.QueryName(0x10040008).等级 = 0
	G.QueryName(0x10040008).经验 = 0
	G.QueryName(0x10040009).等级 = 0
	G.QueryName(0x10040009).经验 = 0
	G.QueryName(0x1004000a).等级 = 0
	G.QueryName(0x1004000a).经验 = 0
	G.QueryName(0x1004000b).等级 = 0
	G.QueryName(0x1004000b).经验 = 0
	G.QueryName(0x1004000c).等级 = 0
	G.QueryName(0x1004000c).经验 = 0
	G.QueryName(0x1004000d).等级 = 0
	G.QueryName(0x1004000d).经验 = 0
	G.QueryName(0x1004000e).等级 = 0
	G.QueryName(0x1004000e).经验 = 0
	G.QueryName(0x1004000f).等级 = 0
	G.QueryName(0x1004000f).经验 = 0
	G.QueryName(0x10040010).等级 = 0
	G.QueryName(0x10040010).经验 = 0
	G.QueryName(0x10040011).等级 = 0
	G.QueryName(0x10040011).经验 = 0
	G.QueryName(0x10040012).等级 = 0
	G.QueryName(0x10040012).经验 = 0
	G.QueryName(0x10040013).等级 = 0
	G.QueryName(0x10040013).经验 = 0
	G.QueryName(0x10040014).等级 = 0
	G.QueryName(0x10040014).经验 = 0
	G.QueryName(0x10040015).等级 = 0
	G.QueryName(0x10040015).经验 = 0
	G.QueryName(0x10040016).等级 = 0
	G.QueryName(0x10040016).经验 = 0
	G.QueryName(0x10040017).等级 = 0
	G.QueryName(0x10040017).经验 = 0
	G.QueryName(0x10040018).等级 = 0
	G.QueryName(0x10040018).经验 = 0
	G.QueryName(0x10040019).等级 = 0
	G.QueryName(0x10040019).经验 = 0
	G.QueryName(0x1004001a).等级 = 0
	G.QueryName(0x1004001a).经验 = 0
	G.QueryName(0x1004001b).等级 = 0
	G.QueryName(0x1004001b).经验 = 0
	G.QueryName(0x1004001c).等级 = 0
	G.QueryName(0x1004001c).经验 = 0
	G.QueryName(0x1004001d).等级 = 0
	G.QueryName(0x1004001d).经验 = 0
	G.QueryName(0x1004001e).等级 = 0
	G.QueryName(0x1004001e).经验 = 0
	G.QueryName(0x1004001f).等级 = 0
	G.QueryName(0x1004001f).经验 = 0
	G.QueryName(0x10040020).等级 = 0
	G.QueryName(0x10040020).经验 = 0
end
--type=通用指令
--hide=false
--private=false
--ret=boolean
t['通用_检查秘籍'] = function(o_item_秘籍,int_等级)
	if int_等级 == nil then
		int_等级 = 1;
	end
	if o_item_秘籍 then
		return o_item_秘籍.修炼层数 >= int_等级;
	else
		return false;
	end
end
--type=通用指令
--hide=false
--private=false
--ret=_int
t['通用_计算武功伤害'] = function(o_kungfu_武功)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	local string_效果类型 = o_kungfu_武功.效果类型
	local int_武功等级 = o_kungfu_武功.等级
	local o_kungfu_power_效果 = nil
	local int_数值 = 0
	local int_随机数值 = 0
	if o_kungfu_武功.需物品 ~= nil then
		if "飞镖" == string_效果类型 then
			int_数值 = o_role_主角.暗器 * 0.4 + o_role_主角.用毒 * 0.1
			int_数值 = int_数值 * o_role_主角.力道1 / 10
		elseif "生死符" == string_效果类型 then
			int_数值 = 1800 * o_role_主角.暗器 / 100
		else
			return {0,0}
		end
		int_数值 = G.call("运算_向下取整",int_数值)
		return {int_数值, int_数值+int_随机数值}
	elseif int_武功等级 == nil or int_武功等级 < 1 then 
		return {0,0}
	else 
	end
	o_kungfu_power_效果 = o_kungfu_武功.效果[int_武功等级]
	if o_kungfu_power_效果 == nil then 
		return {0,0} 
	else 
	end
	int_数值 = o_kungfu_power_效果.基准值
	if "吐纳术" == string_效果类型 then 
		int_数值 = int_数值 * o_role_主角.医疗 / 100
	elseif "寒冰真气" == string_效果类型 then 
		
	elseif "北冥神功" == string_效果类型 then 
		
	elseif "通常(内功)" == string_效果类型 then 
		
	elseif "太玄神功" == string_效果类型 then 
		int_随机数值 = 100 * int_武功等级
	elseif "绝招" == string_效果类型 then 
		int_数值 = o_role_主角.拳掌 + o_role_主角.御剑 + o_role_主角.用毒 + o_role_主角.暗器
		int_数值 = int_数值 * o_kungfu_power_效果.基准值 * o_role_主角.力道1 / 10000
	else 
		int_数值 = int_数值 + o_kungfu_power_效果.用毒系数 * o_role_主角.用毒
		int_数值 = int_数值 + o_kungfu_power_效果.太极系数 * G.call("运算_随机数",0,o_combat_enemy_对手.攻击伤害下限,o_combat_enemy_对手.攻击伤害上限)
		if 10 <= int_武功等级 then 
			int_数值 = int_数值 + o_kungfu_power_效果.侠义系数 * G.call("运算_向下取整",o_role_主角.侠义 / 20)
		else 
			int_数值 = int_数值 + o_kungfu_power_效果.侠义系数 * G.call("运算_向下取整",o_role_主角.侠义 / 30)
		end
		if "通常(大随机)" == string_效果类型 and int_武功等级 < 10 then 
			int_随机数值 = o_role_主角.力道1
			int_随机数值 = int_随机数值 + o_kungfu_power_效果.拳掌系数 * o_role_主角.拳掌
			int_随机数值 = int_随机数值 + o_kungfu_power_效果.御剑系数 * o_role_主角.御剑
		else 
			int_数值 = int_数值 + o_kungfu_power_效果.拳掌系数 * o_role_主角.拳掌
			int_数值 = int_数值 + o_kungfu_power_效果.御剑系数 * o_role_主角.御剑
			if "通常(小随机)" == string_效果类型 and 10 <= int_武功等级 then 
				int_数值 = int_数值 + o_role_主角.力道1
			else 
				int_随机数值 = o_role_主角.力道1
			end
		end
	end
	int_数值 = G.call("运算_向下取整",int_数值)
	int_随机数值 = G.call("运算_向下取整",int_随机数值)
	return {int_数值, int_数值+int_随机数值}
end
--type=通用指令
--hide=false
--private=false
--ret=int
--text=获取全局标记<00>[var:1]
t['通用_获取全局标记'] = function(o_flag_标记)
	if o_flag_标记 ~= nil then
		return o_flag_标记.值
	else
		return 0
	end
end
--type=通用指令
--hide=false
--private=false
--text=设置全局标记<00>[var:1]<06>为<00>[var:2]
t['通用_设置全局标记'] = function(o_flag_标记,int_数值)
	if o_flag_标记 ~= nil then
		o_flag_标记.值 = int_数值;
	end
end
--type=通用指令
--hide=false
--private=false
t['通用_延时'] = function(int_延时)
    if int_延时 ~= nil and int_延时 > 0 then
        G.wait_time(int_延时)
    end
end
--type=通用指令
--hide=true
--private=false
--ret=string
t['通用_数字转文本'] = function(int_数字)
    if int_数字 ~= nil then
		return tostring(int_数字)
	else
		return ""
    end
end
--type=通用指令
--hide=false
--private=false
t['通用_播放音乐'] = function(audio_音乐)
	if G.misc().当前背景音乐 == audio_音乐 then
		return;
	end
	G.misc().当前背景音乐 = audio_音乐;
	if audio_音乐 then
		local boolean_结果 = G.Play(audio_音乐, 1, true, 0, 0);
	end
end
--type=通用指令
--hide=false
--private=false
t['通用_播放音效'] = function(audio_音效)
    local int_通道 = G.misc().当前音效通道;
    local boolean_结果 = false
    if not audio_音效 then
        return
    end
	if int_通道 then
		int_通道 = int_通道 + 1;
		if int_通道 > 10 then
			int_通道 = 1;
		end
	else
		int_通道 = 1;
	end
    G.misc().当前音效通道 = int_通道;
    boolean_结果 = G.Play(audio_音效, 1, false, int_通道, 0);
end
--type=通用指令
--hide=false
--private=false
t['通用_停止音乐'] = function()
	G.Stop(0, 0);
end
--type=通用指令
--hide=false
--private=false
t['通用_停止音效'] = function()
    for int_通道 = 1, 10 do
        G.Stop(int_通道, 0);
    end
end
--type=通用指令
--hide=false
--private=false
t['通用_停止所有声音'] = function()
    for int_通道 = 0, 10 do
        G.Stop(int_通道, 0);
    end
end
--type=数字运算
--hide=false
--private=false
t['运算_初始化随机数'] = function()
	math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) );
end
--type=数字运算
--hide=false
--private=false
--ret=int
t['运算_随机数'] = function(int_下限,int_上限)
    local int_随机数 = 0;
	if int_上限 == nil and int_下限 ~= nil then
		int_上限 = int_下限;
        int_下限 = 0;
    end
    if int_下限 == nil and int_上限 == nil then
        int_随机数 = math.random();
    elseif int_下限 == nil then
        int_随机数 = math.random(int_上限);
    elseif int_上限 == nil then
        int_随机数 = math.random(int_下限);
    else
        int_随机数 = math.random(int_下限, int_上限);
    end
    return int_随机数;
end
--type=数字运算
--hide=false
--private=false
--ret=int
t['运算_限制范围'] = function(int_原数据,int_下限,int_上限)
	if int_原数据 < int_下限 then
		return int_下限;
	elseif int_原数据 > int_上限 then
		return int_上限;
	else
		return int_原数据;
	end
end
--type=数字运算
--hide=false
--private=false
--ret=int
t['运算_向下取整'] = function(int_原数据)
	return math.floor(int_原数据);
end
--type=数字运算
--hide=false
--private=false
--ret=int
t['运算_向上取整'] = function(int_原数据)
	return math.ceil(int_原数据);
end
--type=数字运算
--hide=false
--private=false
--ret=int
t['运算_绝对值'] = function(int_原数据)
	return math.abs(int_原数据);
end
