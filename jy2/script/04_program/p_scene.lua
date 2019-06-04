--[[4001

]]
local G = require "gf"
local t = G.api
local L = {}
--type=场景系统
--hide=false
--private=false
t['场景系统_初始化剧本'] = function()
	G.remove_program("场景系统_管理剧本", 1)
	G.start_program("场景系统_管理剧本")
end
--type=场景系统
--hide=false
--private=false
t['场景系统_管理剧本'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	o_base_游戏数据.当前剧本 = nil
	o_base_游戏数据.下个剧本 = nil
	while true do 
		o_base_游戏数据 = G.QueryName(0x10050001)
		if o_base_游戏数据.下个剧本 == nil then 
			G.wait1({"切换剧本"},nil,nil,nil)
		else 
			o_base_游戏数据.当前剧本 = o_base_游戏数据.下个剧本
			o_base_游戏数据.下个剧本 = nil
			-- print("场景系统_管理剧本 切换剧本", o_base_游戏数据.当前剧本)
			-- G.tabPrint(o_base_游戏数据.当前剧本)
			G.call(o_base_游戏数据.当前剧本)
			o_base_游戏数据.当前剧本 = nil
			o_base_游戏数据.允许剧本事件 = true
		end
	end
end
--type=场景系统
--hide=false
--private=false
t['场景系统_切换剧本'] = function(fargo_drama_剧本)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	o_base_游戏数据.下个剧本 = fargo_drama_剧本
	G.trig_event("切换剧本",nil)
end
--type=场景系统
--hide=false
--private=false
--ret=boolean
t['场景系统_检查能否触发事件'] = function()
	local o_base_游戏数据 = G.QueryName(0x10050001)
	return o_base_游戏数据.允许剧本事件
end
--type=场景系统
--hide=false
--private=false
t['场景系统_初始化'] = function()
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_清空'] = function()
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_隐藏'] = function()
	G.call('通用_关闭所有界面')
	G.call("场景系统_变色", 0x0)
end
--type=场景系统
--hide=false
--private=false
t['场景系统_显示'] = function()
	G.call("场景系统_变色", 0xFFFFFF)
end
--type=场景系统
--hide=false
--private=false
t['场景系统_变色'] = function(color_颜色)
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_设置背景图片'] = function(image_背景图片)
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_显示主地图地点'] = function(boolean_显示)
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_显示主界面'] = function(boolean_显示)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	G.call("场景系统_更新主界面", o_role_主角)
end
--type=场景系统
--hide=false
--private=false
t['场景系统_更新主界面'] = function(o_role_主角)
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_添加跳转按钮'] = function(string_场景名,image_图片)
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_显示指令按钮'] = function(_string_指令名)
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_添加静态人物'] = function(image_头像,int_坐标X,int_坐标Y,string_标识名称,o_common_actionlist_动画)
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_添加交互人物'] = function(image_头像,int_坐标X,int_坐标Y,string_标识名称)
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_添加战斗模型'] = function(int_坐标X,int_坐标Y,string_标识名称,int_动作编号,boolean_循环播放)

end
--type=场景系统
--hide=false
--private=false
t['场景系统_播放战斗动作'] = function(string_标识名称,int_动作编号,boolean_循环播放)

end
--type=场景系统
--hide=false
--private=false
t['场景系统_播放通用动画'] = function(string_标识名称,o_common_actionlist_动画,boolean_并行播放)
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_移除人物'] = function(string_标识名称)
	
end
--type=场景系统
--hide=false
--private=false
t['场景系统_休息'] = function()
	G.call("场景系统_隐藏")
	G.call("通用_播放音效",0x49000025)
	G.call("通用_变更人物属性","生命","增减",9999)
	G.call("通用_变更人物属性","内力","增减",9999)
	G.call("场景系统_显示")
end
--type=场景系统
--hide=false
--private=false
--ret=string
t['场景系统_等待场景交互'] = function()
    G.wait1({"场景_场景交互"},nil,nil,nil)
    return G.event_info()
end
--type=场景系统
--hide=false
--private=false
t['场景系统_播放序列帧动画'] = function(int_动画编号,int_坐标X,int_坐标Y)
    G.call('场景系统_播放序列帧动画ui', int_动画编号, int_坐标X, int_坐标Y);
    G.wait1('场景系统_播放序列帧动画_结束');
end
