local G = require "gf"
local noti = G.notify

function noti.场景系统_初始化()
    G.addUI('v_scene');
    local ui_obj = G.getUI('v_scene');
    if not ui_obj then
        return
    end
    noti.场景系统_清空();
end

function noti.场景系统_清空()
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    c_scene.背景图片.removeAllChildren();
    c_scene.跳转.removeAllChildren();
    c_scene.指令.removeAllChildren();
    c_scene.背景图片.visible = false;
    c_scene.主地图地点.visible = false;
    c_scene.序列帧动画.visible = false;
    c_scene.主界面.visible = false;
    -- c_scene.人物界面.visible = false;
    -- c_scene.武功界面.visible = false;
    -- c_scene.物品界面.visible = false;
    -- c_scene.秘籍界面.visible = false;
    -- c_scene.组件模板.visible = false;
end

function noti.场景系统_变色(color_颜色)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    ui_obj = c_scene.颜色遮罩;
    if color_颜色 == nil then
        color_颜色 = 0x0
    end
    if not ui_obj.visible then
        ui_obj.alpha = 0;
        ui_obj.color = color_颜色
        ui_obj.visible = true;
        G.Tween('alpha', 800, ui_obj, 255);
        G.wait_time(1000);
    end
end

function noti.场景系统_隐藏()
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    ui_obj.visible = false;
    ui_obj = c_scene.颜色遮罩;
    if ui_obj then
        ui_obj.color = 0x0;
        ui_obj.alpha = 255
        ui_obj.visible = true;
    end
end

function noti.场景系统_显示()
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    ui_obj.visible = true;
    ui_obj = c_scene.颜色遮罩;
    if ui_obj.visible then
        G.Tween('alpha', 800, ui_obj, 0);
        G.wait_time(1000);
        ui_obj.visible = false;
    end
end

function noti.场景系统_设置背景图片(image_背景图片)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    c_scene.背景图片.img = image_背景图片;
    c_scene.背景图片.visible = (image_背景图片 ~= nil);
end

function noti.场景系统_显示主地图地点(boolean_显示)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
	if c_scene ~= nil then
		c_scene.主地图地点.visible = boolean_显示;
	end
end

function noti.场景系统_显示主界面(boolean_显示)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
	if c_scene ~= nil then
		c_scene.主界面.visible = boolean_显示;
	end
end

function noti.场景系统_更新主界面(o_role_主角)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
	if c_scene ~= nil then
        local ui = c_scene.主界面;
        ui.getChildAt(0).img = o_role_主角.头像;
        ui.getChildAt(1).text = o_role_主角.姓名;
        ui.getChildAt(2).text = o_role_主角.称号;
        ui = ui.getChildAt(3);
        ui.getChildAt(0).getChildAt(2).width = 90 * G.clamp(o_role_主角.生命 / o_role_主角.生命上限, 0, 1);
        ui.getChildAt(1).getChildAt(2).width = 90 * G.clamp(o_role_主角.内力 / o_role_主角.内力上限, 0, 1);
        ui.getChildAt(2).getChildAt(2).width = 90 * G.clamp(o_role_主角.经验 / o_role_主角.经验上限, 0, 1);
	end
end

function noti.场景系统_添加跳转按钮(string_场景名, image_图片)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    -- wait fulfill
    local ui = G.Clone(c_scene.按钮_跳转);
    ui.name = string_场景名
    ui.c_handle_click.事件参数一 = string_场景名
    if image_图片 ~= nil then
        string_场景名 = '  ' .. string_场景名
    end
    ui.c_button.text = string_场景名
    ui.getChildByName('图片').img = image_图片
    c_scene.跳转.addChild(ui)
    c_scene.跳转.visible = true;
end

function noti.场景系统_显示指令按钮(_string_指令名)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    -- wait fulfill
    c_scene.指令.removeAllChildren();
    for i = 1, #_string_指令名 do
        local string_指令名 = _string_指令名[i];
        local ui = G.Clone(c_scene.按钮_指令);
        ui.name = string_指令名
        ui.c_handle_click.事件参数一 = string_指令名
        ui.c_button.text = string_指令名
        c_scene.指令.addChild(ui)
    end
    c_scene.指令.visible = true;
end

function noti.场景系统_添加静态人物(image_头像, int_坐标X, int_坐标Y, string_标识名称, o_common_actionlist_动画)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    -- wait fulfill
    local ui = G.Clone(c_scene.静态头像框);
    ui.name = string_标识名称;
    ui.img = image_头像;
    ui.x = int_坐标X;
    ui.y = int_坐标Y;
    c_scene.背景图片.addChild(ui);
    G.CallAction('通用_播放动画序列', o_common_actionlist_动画, ui);
end

function noti.场景系统_添加交互人物(image_头像, int_坐标X, int_坐标Y, string_标识名称)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    -- wait fulfill
    local ui = G.Clone(c_scene.交互头像框);
    ui.name = string_标识名称;
    ui.img = image_头像;
    ui.x = int_坐标X;
    ui.y = int_坐标Y;
    local ui_name = ui.getChildAt(1)
    ui_name.text = G.call('通用_处理转意字符', string_标识名称);
    if #string_标识名称 > 9 then
        ui_name.wordSpace = -2;
    else
        ui_name.wordSpace = 2;
    end
    ui.getChildAt(0).c_handle_click.事件参数一 = string_标识名称
    c_scene.背景图片.addChild(ui);
end

function noti.场景系统_添加战斗模型(int_坐标X, int_坐标Y, string_标识名称, int_动作编号, boolean_循环播放)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    -- wait fulfill
    local ui = G.Clone(c_scene.战斗模型);
    ui.name = string_标识名称;
    ui.img = 0x33001001;
    ui.x = int_坐标X;
    ui.y = int_坐标Y;
    local c_framelist = ui.c_framelist;
    if c_framelist then
        c_framelist.循环播放 = boolean_循环播放;
        c_framelist.动作编号 = int_动作编号;
    end
    ui.visible = true;
    c_scene.背景图片.addChild(ui);
end

function noti.场景系统_播放战斗动作(string_标识名称, int_动作编号, boolean_循环播放)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    -- wait fulfill
    local ui = c_scene.背景图片.getChildByName(string_标识名称);
    if ui then
        local c_framelist = ui.c_framelist;
        if c_framelist then
            c_framelist.循环播放 = boolean_循环播放;
            c_framelist.动作编号 = int_动作编号;
        end
    end
end

function noti.场景系统_播放通用动画(string_标识名称, o_common_actionlist_动画, boolean_并行播放)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    -- wait fulfill
    local ui = c_scene.背景图片.getChildByName(string_标识名称);
    if ui then
        if boolean_并行播放 then
            G.RunAction('通用_播放动画序列', o_common_actionlist_动画, ui);
        else
            G.CallAction('通用_播放动画序列', o_common_actionlist_动画, ui);
        end
    end
end

function noti.场景系统_移除人物(string_标识名称)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    -- wait fulfill
    local ui = c_scene.背景图片.getChildByName(string_标识名称);
    if ui then
        c_scene.背景图片.removeChild(ui);
    end
end

function noti.场景系统_播放序列帧动画ui(int_动画编号, int_坐标X, int_坐标Y)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    -- wait fulfill
    c_scene.序列帧动画.x = int_坐标X;
    c_scene.序列帧动画.y = int_坐标Y;
    c_scene.序列帧动画.visible = true;
    c_scene.序列帧动画.frameActionID(int_动画编号);
end

function noti.场景系统_播放序列帧动画_结束end(int_动画编号, int_坐标X, int_坐标Y)
    local ui_obj = G.getUI('v_scene') or G.addUI('v_scene');
    local c_scene = ui_obj.c_scene;
    -- wait fulfill
    c_scene.序列帧动画.visible = false;
end
