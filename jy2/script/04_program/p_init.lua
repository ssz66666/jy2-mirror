--[[0

]]
local G = require "gf"
local t = G.api
local L = {}
--type=系统
--hide=false
--private=false
t['初始化'] = function()
	G.call("运算_初始化随机数")
	G.call("场景系统_初始化")
	G.call('场景系统_初始化剧本')
	G.call("战斗系统_初始化",0x56061001)
	G.start_program('通用_UI交互响应')
	G.call("通用_显示开始菜单")
	-- G.addUI('v_info');
	-- G.call("通用_关闭开始菜单")
	-- local o_base_游戏数据 = G.QueryName(0x10050001)
	-- local o_role_主角 = o_base_游戏数据.主角
	-- o_role_主角.生命 = 9999
	-- o_role_主角.力道 = 9999
	-- o_role_主角.身法 = 9999
	-- o_role_主角.拳掌 = 9999
	-- G.call("通用_变更物品数量", G.QueryName(0x1006002b), 1)
	-- G.call("场景系统_切换剧本",{n = 0, "剧情_黑木崖"})
	-- G.call("剧情_序")
	-- G.call("剧情_衡阳")
	-- G.call("剧情_主地图")
						-- G.call("通用_设置全局标记",G.QueryName(0x10070012),1)
	-- G.call("剧情_侠客岛")
	
	-- G.call("通用_设置全局标记",G.QueryName(0x1007000b),1)
	-- G.call("剧情_衡阳客栈")
	-- G.call("剧情_襄阳")
end