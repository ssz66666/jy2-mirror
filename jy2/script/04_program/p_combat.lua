--[[4002

]]
local G = require "gf"
local t = G.api
local L = {}
--type=战斗系统
--hide=false
--private=false
--text=战斗初始化 <06>地图<00>[var:1] <06>对手头像<00>[var:2] <06>对手模型<00>[var:3] <06>允许逃跑<00>[var:4]
t['战斗系统_初始化'] = function(image_战场,image_头像,o_fight_model_战斗模型,boolean_允许逃跑)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	if image_头像 then
		o_combat_enemy_对手.头像 = image_头像
	end
	o_combat_enemy_对手.允许逃跑 = boolean_允许逃跑
	G.call('通用_更新人物装备属性')
	G.call("战斗系统_更新我方属性",o_role_主角)
	G.call("通用_变更人物属性","集气","设为",0)
	if o_fight_model_战斗模型 ~= nil then
		o_combat_enemy_对手.战斗模型 = o_fight_model_战斗模型
		G.call("战斗系统_播放动作序列",o_fight_model_战斗模型.待机动作,false)
	end
	G.call("战斗系统_播放动作序列",{{n = 2, "战斗系统_播放人物动作", nil, 0}},true)
end
--type=战斗系统
--hide=false
--private=false
t['战斗系统_显示'] = function()
	
end
--type=战斗系统
--hide=false
--private=false
t['战斗系统_隐藏'] = function()
	G.call('通用_关闭所有界面')
end
--type=战斗系统
--hide=false
--private=false
--text=设置对手属性 <06>生命<00>[var:1] <06>内力<00>[var:2] <06>身法<00>[var:3] <06>攻击<00>[var:4]~[var:5] <06>绝招<00>[var:6]~[var:7] <06>耗内<00>[var:8] <06>功力<00>[var:9]
t['战斗系统_设置对手属性1'] = function(int_生命,int_内力,int_身法,int_攻击伤害下限,int_攻击伤害上限,int_绝招伤害下限,int_绝招伤害上限,int_绝招耗内,percent_功力)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	if percent_功力 == nil then
		percent_功力 = 1
	end
	o_combat_enemy_对手.生命上限 = G.call('运算_向上取整', int_生命 * percent_功力)
	o_combat_enemy_对手.生命 = G.call('运算_向上取整', int_生命 * percent_功力)
	o_combat_enemy_对手.内力上限 = G.call('运算_向上取整', int_内力 * percent_功力)
	o_combat_enemy_对手.内力 = G.call('运算_向上取整', int_内力 * percent_功力)
	o_combat_enemy_对手.身法 = G.call('运算_向上取整', int_身法 * percent_功力)
	o_combat_enemy_对手.攻击伤害下限 = G.call('运算_向下取整', int_攻击伤害下限 * percent_功力)
	o_combat_enemy_对手.攻击伤害上限 = G.call('运算_向上取整', int_攻击伤害上限 * percent_功力)
	o_combat_enemy_对手.绝招伤害下限 = G.call('运算_向下取整', int_绝招伤害下限 * percent_功力)
	o_combat_enemy_对手.绝招伤害上限 = G.call('运算_向上取整', int_绝招伤害上限 * percent_功力)
	o_combat_enemy_对手.绝招耗内 = G.call('运算_向下取整', int_绝招耗内 * percent_功力)
	G.call('战斗系统_设置对手属性ui', o_combat_enemy_对手)
end
--type=战斗系统
--hide=false
--private=false
--text=设置对手属性 <06><00>[var:1] <06>为<00>[var:2]
t['战斗系统_设置对手属性'] = function(estr_对手属性_属性, int_数值)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	if int_数值 == nil then
		return
	end
	if '攻击伤害下限' == estr_对手属性_属性 or '绝招伤害下限' == estr_对手属性_属性 or '绝招耗内' == estr_对手属性_属性 then
		int_数值 = G.call('运算_向下取整', int_数值)
	else
		int_数值 = G.call('运算_向上取整', int_数值)
	end
	o_combat_enemy_对手[estr_对手属性_属性] = int_数值
	if '生命' == estr_对手属性_属性 or '内力' == estr_对手属性_属性 then
		estr_对手属性_属性 = estr_对手属性_属性 .. '上限'
		o_combat_enemy_对手[estr_对手属性_属性] = int_数值
		G.call('战斗系统_设置对手属性ui', o_combat_enemy_对手)
	else
	end
end
--type=战斗系统
--hide=false
--private=false
--text=胜利后获得 <06>声望<00>[var:1] <06>银两<00>[var:2] <06>经验<00>[var:3]
t['战斗系统_设置胜利奖励'] = function(int_声望,int_银两,int_经验)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	o_combat_enemy_对手.奖励声望 = G.call('运算_向下取整', int_声望)
	o_combat_enemy_对手.奖励银两 = G.call('运算_向下取整', int_银两)
	o_combat_enemy_对手.奖励经验 = G.call('运算_向下取整', int_经验)
end
--type=战斗系统
--hide=false
--private=false
--ret=enum_战斗结果
t['战斗系统_开始战斗'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	-- local o_fight_model_对手动作 = o_combat_enemy_对手.战斗模型
	local enum_战斗结果_战斗结果 = nil
	-- G.call("战斗系统_播放动作序列",o_fight_model_对手动作.待机动作,false)
	-- G.call("战斗系统_播放动作序列",{{n = 2, "战斗系统_播放人物动作", nil, 0}},true)
	G.start_program("战斗系统_战斗事件监听")
	G.call("战斗系统_操作面板_开启")
	G.start_program("战斗系统_对手集气")
	G.start_program("战斗系统_我方集气")
	G.call("通用_播放音效",0x49000010)
end
--type=战斗系统
--hide=false
--private=false
--ret=enum_战斗结果
t['战斗系统_等待战斗结束'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	local o_fight_model_对手动作 = o_combat_enemy_对手.战斗模型
	local enum_战斗结果_战斗结果 = nil
	enum_战斗结果_战斗结果 = G.call('通用_等待事件', '战斗结束')
	G.remove_program("战斗系统_战斗事件监听")
	G.call("战斗系统_操作面板_关闭")
	G.call("战斗系统_停止对手集气")
	G.call("战斗系统_停止我方集气")
	G.remove_program("战斗系统_对手行动")
	G.remove_program("战斗系统_我方行动")
	G.call("战斗系统_显示我方武功名", "")

	if enum_战斗结果_战斗结果 == 1 then 
		G.call("战斗系统_播放动作序列",o_fight_model_对手动作.失败动作,false)
		G.call("战斗系统_播放动作序列",{{n = 2, "战斗系统_播放人物动作", nil, 4}},true)
		G.call("通用_播放音效",0x4900001c)
		G.call('战斗系统_战后结算')
	elseif enum_战斗结果_战斗结果 == 0 then 
		G.call("战斗系统_播放动作序列",o_fight_model_对手动作.待机动作,false)
		G.call("战斗系统_播放动作序列",{{n = 2, "战斗系统_播放人物动作", nil, 2}},true)
		G.call("通用_播放音效",0x4900001d)
	else 
		G.call("战斗系统_播放动作序列",o_fight_model_对手动作.待机动作,false)
		G.call("战斗系统_播放动作序列",{{n = 2, "战斗系统_播放人物动作", nil, 3}, {n = 2, "战斗系统_播放音效", 333, 0x49000023}},true)
		G.call('通用_变更人物属性', '声望', '乘以', 0.9)
	end
	G.call("战斗系统_显示战斗结果",enum_战斗结果_战斗结果)
	G.wait1({"战斗系统_显示战斗结果完毕"},nil,nil,nil)
	G.wait1({"战斗系统_任意点击继续"},nil,nil,nil)
	if o_role_主角.生命 < 1 then 
		o_role_主角.生命 = 1
	else 
	end
	return enum_战斗结果_战斗结果
end
--type=战斗系统
--hide=false
--private=true
--ret=enum_战斗结果
t['战斗系统_战斗事件监听'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	local o_fight_model_对手动作 = o_combat_enemy_对手.战斗模型
	local enum_战斗结果_战斗结果 = nil
	while true do 
		do 
			G.case(1,{"战斗开始"},nil,nil,nil)
			G.case(2,{"战斗_对手集气完成"},nil,nil,nil)
			G.case(3,{"战斗_对手行动完毕"},nil,nil,nil)
			G.case(4,{"战斗_我方行动完毕"},nil,nil,nil)
			local c = G.wait_case()
			if c == 1 then 
				
			elseif c == 2 then 
				G.remove_program("战斗系统_对手行动")
				G.start_program("战斗系统_对手行动")
			elseif c == 3 then 
				G.call("战斗系统_播放动作序列",o_fight_model_对手动作.待机动作,false)
				G.start_program("战斗系统_对手集气")
			elseif c == 4 then 
				G.call("战斗系统_播放动作序列",{{n = 2, "战斗系统_播放人物动作", nil, 0}},true)
				G.start_program("战斗系统_我方集气")
			end
		end
	end
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_操作面板_开启'] = function()
	G.start_program("战斗系统_操作面板响应")
end
--type=战斗系统
--hide=false
--private=false
t['战斗系统_操作面板_关闭'] = function()
	G.remove_program("战斗系统_操作面板响应")
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_操作面板响应'] = function()
	local int_集气数量 = nil
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local string_武功类型 = o_base_游戏数据.当前选择武功类型 or "拳"
	local _o_kungfu_可用武功 = nil
	local int_选择武功序号 = nil
	local o_kungfu_选择武功 = nil
	G.call("战斗系统_操作面板_更新武功类型", string_武功类型)
	_o_kungfu_可用武功 = G.call("战斗系统_获取可用武功",string_武功类型)
	G.call("战斗系统_操作面板_更新武功状态",o_base_游戏数据,_o_kungfu_可用武功)
	while true do 
		do 
			G.case(1,{"战斗_我方集气完成", nil},"选项",nil,nil)
			G.case(2,{"战斗_操作面板_切换武功类型", nil},nil,nil,nil)
			G.case(3,{"战斗_操作面板_选择武功", nil},nil,nil,nil)
			G.case(4,{"战斗_操作面板_查看属性"},"选项",nil,nil)
			G.case(5,{"战斗_操作面板_逃跑"},"选项",nil,nil)
			local c = G.wait_case()
			if c == 1 then 
				int_集气数量 = G.event_info()
				G.call("通用_变更人物属性","集气","设为",int_集气数量)
				G.call("战斗系统_操作面板_更新武功状态",o_base_游戏数据,_o_kungfu_可用武功)
			elseif c == 2 then 
				string_武功类型 = G.event_info()
				o_base_游戏数据.当前选择武功类型 = string_武功类型
				G.call("战斗系统_操作面板_更新武功类型", string_武功类型)
				_o_kungfu_可用武功 = G.call("战斗系统_获取可用武功",string_武功类型)
				G.call("战斗系统_操作面板_更新武功状态",o_base_游戏数据,_o_kungfu_可用武功)
			elseif c == 3 then 
				int_选择武功序号 = G.event_info()
				o_kungfu_选择武功 = _o_kungfu_可用武功[int_选择武功序号 + 1]
				if o_kungfu_选择武功 ~= nil then 
					G.call("战斗系统_停止我方集气")
					G.call("通用_变更人物属性","内力","增减",- o_kungfu_选择武功.需内力 * o_kungfu_选择武功.等级)
					G.call("通用_变更物品数量", o_kungfu_选择武功.需物品, -1)
					_o_kungfu_可用武功 = G.call("战斗系统_获取可用武功",string_武功类型)
					G.call("战斗系统_操作面板_更新武功状态",o_base_游戏数据,_o_kungfu_可用武功)
					G.call("战斗系统_更新状态栏")
					G.remove_program("战斗系统_我方行动")
					G.start_program("战斗系统_我方行动",o_kungfu_选择武功)
				else 
				end
			elseif c == 4 then 
				G.call('通用_显示人物界面')
			elseif c == 5 then 
				G.call("战斗系统_停止我方集气")
				G.call("战斗系统_操作面板_更新武功状态",o_base_游戏数据,_o_kungfu_可用武功)
				G.remove_program("战斗系统_我方行动")
				G.call("战斗系统_显示我方武功名", "")
				if G.call("战斗系统_检查能否逃跑") then 
					G.trig_event("战斗结束",2)
				else 
					G.call("通知系统_显示飘字","逃跑失败",0x49000023,0xFF,'右下',0)
					G.trig_event("战斗_我方行动完毕",2)
				end
			end
		end
	end
end
--type=战斗系统
--hide=false
--private=true
--ret=boolean
t['战斗系统_检查能否逃跑'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local boolean_允许逃跑 = o_base_游戏数据.对手.允许逃跑
	if boolean_允许逃跑 and G.call('运算_随机数', 0, 29) < o_role_主角.身法1 then
		return true;
	else
		return false;
	end
end
--type=战斗系统
--hide=false
--private=true
--ret=_o_kungfu
t['战斗系统_获取可用武功'] = function(string_武功类型)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local _o_kungfu_可用武功 = {G.QueryName(0x10040001)}
	local o_kungfu_武功 = nil
	if string_武功类型 == "拳" then 
		_o_kungfu_可用武功 = {G.QueryName(0x10040001), G.QueryName(0x10040003), G.QueryName(0x10040004), G.QueryName(0x10040005), G.QueryName(0x10040006), G.QueryName(0x10040007), G.QueryName(0x10040008)}
	elseif string_武功类型 == "掌" then 
		_o_kungfu_可用武功 = {G.QueryName(0x10040001), G.QueryName(0x10040009), G.QueryName(0x1004000a), G.QueryName(0x1004000b), G.QueryName(0x1004000c), G.QueryName(0x1004000d), G.QueryName(0x1004000e)}
	elseif string_武功类型 == "指" then 
		_o_kungfu_可用武功 = {G.QueryName(0x10040001), G.QueryName(0x1004000f), G.QueryName(0x10040010), G.QueryName(0x10040011), G.QueryName(0x10040012), G.QueryName(0x10040013), G.QueryName(0x10040014)}
	elseif string_武功类型 == "剑" then 
		_o_kungfu_可用武功 = {G.QueryName(0x10040002), G.QueryName(0x10040015), G.QueryName(0x10040016), G.QueryName(0x10040017), G.QueryName(0x10040018), G.QueryName(0x10040019), G.QueryName(0x1004001a)}
	elseif string_武功类型 == "内" then 
		_o_kungfu_可用武功 = {G.QueryName(0x10040001), G.QueryName(0x1004001b), G.QueryName(0x1004001c), G.QueryName(0x1004001d), G.QueryName(0x1004001e), G.QueryName(0x1004001f), G.QueryName(0x10040020)}
	elseif string_武功类型 == "物品" then 
		_o_kungfu_可用武功 = {G.QueryName(0x10040001), G.QueryName(0x10040021), G.QueryName(0x10040022), G.QueryName(0x10040023), G.QueryName(0x10040024), G.QueryName(0x10040025), G.QueryName(0x10040026)}
	else 
	end
	for int_i = 2, 7, 1 do 
		o_kungfu_武功 = _o_kungfu_可用武功[int_i]
		if o_kungfu_武功 ~= nil then 
			if o_kungfu_武功.需物品 ~= nil then
				if o_kungfu_武功.需物品.数量 <= 0 then
					_o_kungfu_可用武功[int_i] = nil
				end
			elseif o_kungfu_武功.等级 <= 0 then 
				_o_kungfu_可用武功[int_i] = nil
			else 
			end
		else 
		end
	end
	return _o_kungfu_可用武功
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_操作面板_更新武功类型'] = function(string_武功类型)
	
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_操作面板_更新武功状态'] = function(o_base_游戏数据,_o_kungfu_可用武功)

end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_对手集气'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	local int_需时间 = 15000
	if 97 <= o_combat_enemy_对手.身法 then 
		int_需时间 = 1500
	elseif 91 <= o_combat_enemy_对手.身法 then 
		int_需时间 = 2883
	elseif 76 <= o_combat_enemy_对手.身法 then 
		int_需时间 = 4417
	elseif 66 <= o_combat_enemy_对手.身法 then 
		int_需时间 = 6250
	elseif 31 <= o_combat_enemy_对手.身法 then 
		int_需时间 = 6667
	elseif 0 <= o_combat_enemy_对手.身法 then 
		int_需时间 = 8333
	else 
		return 
	end
	G.call("战斗系统_对手集气ui",int_需时间)
	G.wait_time(int_需时间)
	G.trig_event("战斗_对手集气完成",nil)
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_我方集气'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local int_需时间 = 15000
	if 96 <= o_role_主角.身法1 then 
		int_需时间 = 3833
	elseif 81 <= o_role_主角.身法1 then 
		int_需时间 = 5083
	elseif 61 <= o_role_主角.身法1 then 
		int_需时间 = 8000
	elseif 46 <= o_role_主角.身法1 then 
		int_需时间 = 9250
	elseif 0 <= o_role_主角.身法1 then 
		int_需时间 = 12417
	else 
		return 
	end
	G.call("战斗系统_我方集气ui",int_需时间)
	for int_i = 1, 6, 1 do 
		G.wait_time(int_需时间 / 6)
		G.trig_event("战斗_我方集气完成",int_i)
	end
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_停止对手集气'] = function()
	G.remove_program("战斗系统_对手集气", 1)
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_停止我方集气'] = function()
	G.call("通用_变更人物属性","集气","设为",0)
    G.remove_program("战斗系统_我方集气",1)
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_对手行动'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	local o_fight_model_对手动作 = o_combat_enemy_对手.战斗模型
	local boolean_使用绝招 = false
	local estr_绝招类型_绝招类型 = o_fight_model_对手动作.绝招类型
	local int_数值 = 0
	local int_伤害下限 = 0
	local int_随机数值 = 0
	if 1 <= o_fight_model_对手动作.绝招使用率 then 
		G.log("发动率100%的, 不消耗内力")
		boolean_使用绝招 = true
	else
		if estr_绝招类型_绝招类型 == '北冥神功' then
			if o_combat_enemy_对手.内力 < o_combat_enemy_对手.绝招耗内 or G.call("运算_随机数",nil,nil) < o_fight_model_对手动作.绝招使用率 then
				boolean_使用绝招 = true
			else
				boolean_使用绝招 = false
				G.call("战斗系统_变更人物属性","对手","内力",- o_combat_enemy_对手.绝招耗内)
				G.call("战斗系统_更新状态栏")
			end
		else
			if o_combat_enemy_对手.内力 >= o_combat_enemy_对手.绝招耗内 and G.call("运算_随机数",nil,nil) < o_fight_model_对手动作.绝招使用率 then 
				boolean_使用绝招 = true
				G.call("战斗系统_变更人物属性","对手","内力",- o_combat_enemy_对手.绝招耗内)
				G.call("战斗系统_更新状态栏")
			else
				boolean_使用绝招 = false
			end
		end
	end
	if boolean_使用绝招 then 
		G.call("战斗系统_播放动作序列",o_fight_model_对手动作.绝招动作,false)
	else 
		G.call("战斗系统_播放动作序列",o_fight_model_对手动作.攻击动作,false)
	end
	G.wait1({"战斗_对手伤害结算"},nil,nil,nil)
	if boolean_使用绝招 then 
		if estr_绝招类型_绝招类型 == '左右互搏' then
			for int_攻击次数 = 1, 2, 1 do
				int_数值 = G.call("运算_随机数",o_combat_enemy_对手.绝招伤害下限,o_combat_enemy_对手.绝招伤害上限)
				int_伤害下限 = G.call("运算_向上取整", int_数值 / 2) + G.call("运算_随机数",10,20)
				int_数值 = int_数值 - o_role_主角.护体1 * 2
				int_数值 = G.call("运算_限制范围",int_数值,int_伤害下限,9999)
				G.call("战斗系统_显示伤害数值",false,- int_数值,255,150 * (int_攻击次数 - 1))
				G.call('战斗系统_变更人物属性', '我方', '生命', -int_数值)
			end
			G.call("战斗系统_更新状态栏")
			return
		elseif estr_绝招类型_绝招类型 == '吐纳术' then
			int_数值 = 1800
			G.call("战斗系统_显示伤害数值",true,int_数值,12636336.0,0)
			G.call("战斗系统_变更人物属性","对手","生命",int_数值)
			G.call("战斗系统_更新状态栏")
			return
		elseif estr_绝招类型_绝招类型 == '寒冰真气' then
			int_数值 = 15
			G.call("战斗系统_变更人物属性","我方","身法",- int_数值)
			return
		elseif estr_绝招类型_绝招类型 == '北冥神功' then
			int_数值 = G.call("运算_限制范围",1800,0,o_role_主角.内力)
			G.call("战斗系统_显示伤害数值",false,-1800,15761648.0,0)
			G.call("战斗系统_变更人物属性","我方","内力",-1800)
			G.call("战斗系统_显示伤害数值",true,int_数值,15761648.0,500)
			G.call("战斗系统_变更人物属性","对手","内力",int_数值)
			G.call("战斗系统_更新状态栏")
			return
		end
		int_数值 = G.call("运算_随机数",o_combat_enemy_对手.绝招伤害下限,o_combat_enemy_对手.绝招伤害上限)
		int_伤害下限 = G.call("运算_向上取整", int_数值 / 2) + G.call("运算_随机数",10,20)
		int_数值 = int_数值 - o_role_主角.护体1 * 2
	else 
		int_数值 = G.call("运算_随机数",o_combat_enemy_对手.攻击伤害下限,o_combat_enemy_对手.攻击伤害上限)
		int_伤害下限 = G.call("运算_向上取整", int_数值 / 5) + G.call("运算_随机数",0,10)
		int_数值 = int_数值 - o_role_主角.护体1
	end
    int_数值 = G.call("运算_向下取整",int_数值)
	int_数值 = G.call("运算_限制范围",int_数值,int_伤害下限,9999)
	G.call("战斗系统_显示伤害数值",false,- int_数值,255,0)
	G.call('战斗系统_变更人物属性', '我方', '生命', -int_数值)
	G.call("战斗系统_更新状态栏")
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_我方行动'] = function(o_kungfu_武功)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	local string_效果类型 = o_kungfu_武功.效果类型
	local o_item_物品 = o_kungfu_武功.需物品
	local _int_武功威力 = G.call("通用_计算武功伤害", o_kungfu_武功)
	local int_伤害下限 = _int_武功威力[1]
	local int_伤害上限 = _int_武功威力[2]
	local int_数值 = 0
	local int_数值2 = 0
	G.call("战斗系统_显示我方武功名", o_kungfu_武功.名称)
	G.call("战斗系统_播放动作序列",o_kungfu_武功.动画,true)
	G.call('战斗系统_提升武功经验', o_kungfu_武功)
	G.wait1({"战斗_我方伤害结算"},nil,nil,nil)
	G.call("战斗系统_显示我方武功名", "")
	
	if o_item_物品 ~= nil then
		if int_伤害下限 > 0 then
			int_数值 = G.call("运算_随机数",int_伤害下限, int_伤害上限)
			G.call("战斗系统_显示伤害数值",true,- int_数值,255,0)
			G.call("战斗系统_变更人物属性","对手","生命",- int_数值)
		elseif "丹药" == o_item_物品.类型 then
			if o_item_物品.药物效果['加生命%'] ~= nil and o_item_物品.药物效果['加生命%'] ~= 0 then
				int_数值 = o_role_主角.生命上限 * o_item_物品.药物效果['加生命%']
				int_数值 = G.call("运算_向下取整", int_数值)
				G.call("战斗系统_显示伤害数值",false,int_数值,12636336.0,0)
				G.call("战斗系统_变更人物属性","我方","生命",int_数值)
			end
			if o_item_物品.药物效果['加内力%'] ~= nil and o_item_物品.药物效果['加内力%'] ~= 0 then
				int_数值 = o_role_主角.内力上限 * o_item_物品.药物效果['加内力%']
				int_数值 = G.call("运算_向下取整", int_数值)
				G.call("战斗系统_显示伤害数值",false,int_数值,15761648.0,150)
				G.call("战斗系统_变更人物属性","我方","内力",int_数值)
			end
		end
		G.call("战斗系统_更新状态栏")
	elseif "吐纳术" == string_效果类型 then 
		int_数值 = G.call("运算_随机数",int_伤害下限, int_伤害上限)
		G.call("战斗系统_显示伤害数值",false,int_数值,12636336.0,0)
		G.call("战斗系统_变更人物属性","我方","生命",int_数值)
		G.call("战斗系统_更新状态栏")
	elseif "寒冰真气" == string_效果类型 then 
		int_数值 = G.call("运算_随机数",int_伤害下限, int_伤害上限)
		G.call("战斗系统_变更人物属性","对手","身法",- int_数值)
	elseif "北冥神功" == string_效果类型 then 
		int_数值 = G.call("运算_随机数",int_伤害下限, int_伤害上限)
		int_数值2 = G.call("运算_限制范围",int_数值,0,o_combat_enemy_对手.内力)
		G.call("战斗系统_显示伤害数值",true,- int_数值,15761648.0,0)
		G.call("战斗系统_变更人物属性","对手","内力",- int_数值)
		G.call("战斗系统_显示伤害数值",false,int_数值2,15761648.0,500)
		G.call("战斗系统_变更人物属性","我方","内力",int_数值2)
		G.call("战斗系统_更新状态栏")
	else 
		if G.call("通用_获取全局标记",G.QueryName(0x10070011)) > 0 then 
			for int_攻击次数 = 1, 2, 1 do
				int_数值 = G.call("运算_随机数",int_伤害下限, int_伤害上限)
				int_数值 = G.call("运算_向下取整",int_数值 * 0.75)
				int_数值 = G.call("运算_限制范围",int_数值,1,9999)
				G.call("战斗系统_显示伤害数值",true,- int_数值,255,150 * (int_攻击次数 - 1))
				G.call("战斗系统_变更人物属性","对手","生命",- int_数值)
			end
		else 
			int_数值 = G.call("运算_随机数",int_伤害下限, int_伤害上限)
			int_数值 = G.call("运算_限制范围",int_数值,1,9999)
			G.call("战斗系统_显示伤害数值",true,- int_数值,255,0)
			G.call("战斗系统_变更人物属性","对手","生命",- int_数值)
		end
		G.call("战斗系统_更新状态栏")
	end
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_显示伤害数值'] = function(boolean_我方行动,int_数值,color_颜色,int_延时)

end
--type=战斗系统
--hide=false
--private=false
t['战斗系统_显示我方武功名'] = function(string_武功名称)

end
--type=战斗系统
--hide=false
--private=false
t['战斗系统_更新状态栏'] = function(boolean_我方,int_生命,int_内力)

end
--type=战斗系统
--hide=false
--private=true
--text=战斗系统_变更人物属性 [var:1] [var:2] [var:3]
t['战斗系统_变更人物属性'] = function(estr_战斗角色_角色,estr_战斗属性_属性,int_数值)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	local int_属性 = 0
	if "我方" == estr_战斗角色_角色 then 
		if "身法" == estr_战斗属性_属性 then 
			int_属性 = G.call("运算_向下取整",o_role_主角.身法1 + int_数值)
			o_role_主角.身法1 = G.call("运算_限制范围",int_属性,0,100)
			return
		else
		end
		G.call("通用_变更人物属性",estr_战斗属性_属性,"增减",int_数值)
		if "生命" == estr_战斗属性_属性 and o_base_游戏数据.主角.生命 <= 0 then 
			G.trig_event("战斗结束",0)
		else 
		end
	elseif "对手" == estr_战斗角色_角色 then 
		if "生命" == estr_战斗属性_属性 then 
			int_属性 = G.call("运算_向下取整",o_combat_enemy_对手.生命 + int_数值)
			o_combat_enemy_对手.生命 = G.call("运算_限制范围",int_属性,0,o_combat_enemy_对手.生命上限)
			if o_combat_enemy_对手.生命 <= 0 then 
				G.trig_event("战斗结束",1)
			else 
			end
		elseif "内力" == estr_战斗属性_属性 then 
			int_属性 = G.call("运算_向下取整",o_combat_enemy_对手.内力 + int_数值)
			o_combat_enemy_对手.内力 = G.call("运算_限制范围",int_属性,0,o_combat_enemy_对手.内力上限)
		elseif "身法" == estr_战斗属性_属性 then 
			int_属性 = G.call("运算_向下取整",o_combat_enemy_对手.身法 + int_数值)
			o_combat_enemy_对手.身法 = G.call("运算_限制范围",int_属性,0,100)
		else 
		end
	else 
	end
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_提升武功经验'] = function(o_kungfu_武功)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local int_武功等级 = o_kungfu_武功.等级
	local int_武功经验 = o_kungfu_武功.经验
	local _o_kungfu_lvup_升级 = nil
	local o_kungfu_lvup_升级 = nil
	if o_kungfu_武功 == nil then 
		return 
	elseif o_kungfu_武功.需物品 ~= nil then
		return
	else 
	end
	_o_kungfu_lvup_升级 = o_kungfu_武功.升级
	if _o_kungfu_lvup_升级 == nil then 
		return 
	else 
	end
	o_kungfu_lvup_升级 = _o_kungfu_lvup_升级[int_武功等级]
	if o_kungfu_lvup_升级 == nil then 
		return 
	else 
	end
	if 90 <= o_role_主角.悟性 then 
		o_kungfu_武功.经验 = int_武功经验 + 10
	elseif 60 <= o_role_主角.悟性 then 
		o_kungfu_武功.经验 = int_武功经验 + 5
	elseif 0 < o_role_主角.悟性 then 
		o_kungfu_武功.经验 = int_武功经验 + 2
	else 
		return 
	end
	if o_kungfu_lvup_升级.需经验 <= o_kungfu_武功.经验 then 
		o_kungfu_武功.等级 = int_武功等级 + 1
		G.call("通知系统_显示飘字","修为提升",0x4900001a,0xFF,'右下',0)
		G.call("通用_变更人物属性","生命上限","增减",o_kungfu_lvup_升级.加生命)
		G.call("通用_变更人物属性","内力上限","增减",o_kungfu_lvup_升级.加内力)
		G.call("通用_变更人物属性","力道","增减",o_kungfu_lvup_升级.加力道)
		G.call("通用_变更人物属性","护体","增减",o_kungfu_lvup_升级.加护体)
		G.call("通用_变更人物属性","身法","增减",o_kungfu_lvup_升级.加身法)
		G.call("通用_变更人物属性","拳掌","增减",o_kungfu_lvup_升级.加拳掌)
		G.call("通用_变更人物属性","御剑","增减",o_kungfu_lvup_升级.加御剑)
		G.call("通用_变更人物属性","暗器","增减",o_kungfu_lvup_升级.加暗器)
		G.call("通用_变更人物属性","医疗","增减",o_kungfu_lvup_升级.加医疗)
		G.call("通用_变更人物属性","用毒","增减",o_kungfu_lvup_升级.加用毒)
		G.call("通用_变更人物属性","解毒","增减",o_kungfu_lvup_升级.加解毒)
		if o_kungfu_lvup_升级.经络受损 ~= nil and o_kungfu_lvup_升级.经络受损 > 0 then
			G.call("通用_变更人物属性","生命上限","乘以", 1 - o_kungfu_lvup_升级.经络受损)
			G.call("通用_变更人物属性","生命","乘以", 1 - o_kungfu_lvup_升级.经络受损)
			G.call("通知系统_显示飘字","经络受损",0x49000023,0xFF,'右下',500)
		end
		G.call('通用_更新人物装备属性')
	else 
	end
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_显示战斗结果'] = function(enum_战斗结果_战斗结果)

end
--type=
--hide=false
--private=true
--private=true
t['战斗系统_战后结算'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local o_combat_enemy_对手 = o_base_游戏数据.对手
	local _int_升级需经验 = o_base_游戏数据.升级需经验
	local int_等级 = o_role_主角.等级
	local int_需经验 = _int_升级需经验[int_等级]
	local boolean_升级 = false
	o_base_游戏数据 = nil
	G.call("通用_变更人物属性","银两","增减",o_combat_enemy_对手.奖励银两)
	G.call("通用_变更人物属性","声望","增减",o_combat_enemy_对手.奖励声望)
	G.call("通用_变更人物属性","经验","增减",o_combat_enemy_对手.奖励经验)
	while int_需经验 ~= nil and int_需经验 <= o_role_主角.经验 do 
		boolean_升级 = true
		G.call("通用_变更人物属性","等级","增减",1)
		G.call("通用_变更人物属性","经验","增减",- int_需经验)
		int_等级 = o_role_主角.等级
		int_需经验 = _int_升级需经验[int_等级]
		G.call("通用_变更人物属性","经验上限","设为",int_需经验)
		G.call("通用_变更人物属性","学点","增减",1)
		if 40 < int_等级 then 
			G.call("通用_变更人物属性","生命上限","增减",300)
		elseif 30 < int_等级 then 
			G.call("通用_变更人物属性","生命上限","增减",200)
		elseif 20 < int_等级 then 
			G.call("通用_变更人物属性","生命上限","增减",100)
		elseif 10 < int_等级 then 
			G.call("通用_变更人物属性","生命上限","增减",50)
		elseif 1 < int_等级 then 
			G.call("通用_变更人物属性","生命上限","增减",20)
		else 
		end
		G.call("通用_变更人物属性","生命","设为",o_role_主角.生命上限)
		G.call("通用_变更人物属性","力道","增减",G.call("运算_随机数",0,1))
		G.call("通用_变更人物属性","身法","增减",G.call("运算_随机数",0,1))
		G.call("通用_变更人物属性","护体","增减",G.call("运算_随机数",0,1))
	end
	if boolean_升级 then 
		G.call("通知系统_显示等级上升",0x4900001a,0)
	else 
	end
end
--type=战斗系统
--hide=false
--private=true
--private=false
t['战斗系统_播放动作序列'] = function(_fargo_fight_model_action_动作序列,boolean_我方)

end
--type=战斗系统
--hide=true
--private=false
--ret=o_fight_model_action
t['战斗系统_播放人物动作'] = function(int_延时,int_动作编号)
    -->G.log("逻辑在 .\\script\\06_combat\\n_combat.lua 中")
end
--type=战斗系统
--hide=true
--private=false
--ret=o_fight_model_action
t['战斗系统_显示伤害'] = function(int_延时,o_kungfu_武功)
    -->G.log("逻辑在 .\\script\\06_combat\\n_combat.lua 中")
end
--type=战斗系统
--hide=true
--private=false
--ret=o_fight_model_action
t['战斗系统_播放音效'] = function(int_延时,audio_音效)
    -->G.log("逻辑在 .\\script\\06_combat\\n_combat.lua 中")
end
--type=战斗系统
--hide=true
--private=false
--ret=o_fight_model_action
t['战斗系统_播放光影'] = function(int_延时,int_光影编号)
    -->G.log("逻辑在 .\\script\\06_combat\\n_combat.lua 中")
end
--type=战斗系统
--hide=false
--private=false
t['战斗系统_显示圆圈'] = function(int_坐标X,int_坐标Y,int_宽,int_高,color_颜色)

end
--type=战斗系统
--hide=false
--private=false
t['战斗系统_隐藏圆圈'] = function()

end
--type=战斗系统
--hide=false
--private=false
t['战斗系统_显示战斗对话'] = function(string_对话)
	G.call("战斗系统_显示战斗对话ui",string_对话)
	G.wait1({"战斗系统_显示战斗对话_结束"},nil,nil,nil)
end
