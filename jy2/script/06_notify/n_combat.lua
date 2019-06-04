local G = require "gf"
local noti = G.notify


function noti.战斗系统_初始化(image_战场, image_头像, o_fight_model_战斗模型, boolean_允许逃跑)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    local c_combat_role_status = c_combat.对手状态.c_combat_role_status;
    ui_obj.visible = false;
    -- wait fulfill
    -- 清除上一战斗的残留信息
    -- ui_obj.color = 0x0;
    if image_战场 ~= nil and image_战场 > 0 then
        c_combat.战场.img = image_战场;
    end
    if image_头像 ~= nil and image_头像 > 0 then
        c_combat_role_status.头像.img = image_头像;
    end
    c_combat.武功名称.visible = false;
    c_combat.战斗结果.visible = false;
    local c_combat_cpanel = c_combat.操作面板.c_combat_cpanel;
    if c_combat_cpanel then
        c_combat_cpanel:开启(boolean_允许逃跑);
    end
end

function noti.战斗系统_隐藏()
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    -- local c_combat = ui_obj.c_combat;
    if 0x0 ~= ui_obj.color then
        G.Tween('color', 800, ui_obj, 0);
        G.wait_time(1000);
    end
    ui_obj.visible = false;
end

function noti.战斗系统_显示()
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    -- local c_combat = ui_obj.c_combat;
    ui_obj.visible = true;
    if 0xFFFFFF ~= ui_obj.color then
        G.Tween('color', 800, ui_obj, 0xFFFFFF);
        G.wait_time(1000);
    end
end
-- function noti.战斗系统_操作面板_开启(boolean_允许逃跑)
--     local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
--     local c_combat = ui_obj.c_combat;
--     if c_combat then
--         local c_combat_cpanel = c_combat.操作面板.c_combat_cpanel;
--         if c_combat_cpanel then
--             c_combat_cpanel:开启(boolean_允许逃跑);
--         end
--     end
-- end
function noti.战斗系统_操作面板_关闭()
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if c_combat then
        local c_combat_cpanel = c_combat.操作面板.c_combat_cpanel;
        if c_combat_cpanel then
            c_combat_cpanel:关闭();
        end
    end
end
function noti.战斗系统_更新我方属性(o_role_主角)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if c_combat then
        local c_combat_role_status = c_combat.我方状态.c_combat_role_status;
        if c_combat_role_status then
            c_combat_role_status.头像.img = o_role_主角.头像;
            c_combat_role_status.生命上限 = o_role_主角.生命上限;
            c_combat_role_status.生命 = o_role_主角.生命;
            c_combat_role_status.内力上限 = o_role_主角.内力上限;
            c_combat_role_status.内力 = o_role_主角.内力;
            c_combat_role_status.内力 = o_role_主角.内力;
            c_combat_role_status.集气比例 = 0;
        end
    end
end
function noti.战斗系统_设置对手属性ui(o_combat_enemy_对手)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if c_combat and o_combat_enemy_对手 then
        local c_combat_role_status = c_combat.对手状态.c_combat_role_status;
        if c_combat_role_status then
            c_combat_role_status.生命上限 = o_combat_enemy_对手.生命上限;
            c_combat_role_status.生命 = o_combat_enemy_对手.生命;
            c_combat_role_status.内力上限 = o_combat_enemy_对手.内力上限;
            c_combat_role_status.内力 = o_combat_enemy_对手.内力;
        end
        c_combat.气槽.width = 0
    end
end
function noti.战斗系统_显示我方武功名(string_武功名称)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if string_武功名称 == nil or string_武功名称 == '' then
        c_combat.武功名称.visible = false;
    else
        c_combat.武功名称.text = string_武功名称;
        c_combat.武功名称.visible = true;
    end
end
function noti.战斗系统_更新状态栏(boolean_我方, int_生命, int_内力)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	local o_combat_enemy_对手 = o_base_游戏数据.对手
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    local int_时间 = 500;
    if c_combat then
        local c_combat_role_status = c_combat.我方状态.c_combat_role_status;
        if c_combat_role_status then
            if c_combat_role_status.生命上限 ~= o_role_主角.生命上限 then
                c_combat_role_status.生命上限 = o_role_主角.生命上限
            end
            if c_combat_role_status.内力上限 ~= o_role_主角.内力上限 then
                c_combat_role_status.内力上限 = o_role_主角.内力上限
            end
            if c_combat_role_status.生命 ~= o_role_主角.生命 then
                G.TweenCom('生命', int_时间, c_combat_role_status, o_role_主角.生命)
            end
            if c_combat_role_status.内力 ~= o_role_主角.内力 then
                G.TweenCom('内力', int_时间, c_combat_role_status, o_role_主角.内力)
            end
        end
        c_combat_role_status = c_combat.对手状态.c_combat_role_status;
        if c_combat_role_status then
            if c_combat_role_status.生命上限 ~= o_combat_enemy_对手.生命上限 then
                c_combat_role_status.生命上限 = o_combat_enemy_对手.生命上限
            end
            if c_combat_role_status.内力上限 ~= o_combat_enemy_对手.内力上限 then
                c_combat_role_status.内力上限 = o_combat_enemy_对手.内力上限
            end
            if c_combat_role_status.生命 ~= o_combat_enemy_对手.生命 then
                G.TweenCom('生命', int_时间, c_combat_role_status, o_combat_enemy_对手.生命)
            end
            if c_combat_role_status.内力 ~= o_combat_enemy_对手.内力 then
                G.TweenCom('内力', int_时间, c_combat_role_status, o_combat_enemy_对手.内力)
            end
        end
    end
    -- if c_combat then
    --     local c_combat_role_status;
    --     print('c_combat_role_status', boolean_我方, int_生命, int_内力)
    --     if true == boolean_我方 then
    --         c_combat_role_status = c_combat.我方状态.c_combat_role_status;
    --     elseif false == boolean_我方 then
    --         c_combat_role_status = c_combat.对手状态.c_combat_role_status;
    --     end
    --     if c_combat_role_status then
    --         if int_生命 ~= nil and c_combat_role_status.生命 ~= int_生命 then
    --             G.TweenCom('生命', int_时间, c_combat_role_status, int_生命)
    --         end
    --         if int_内力 ~= nil and c_combat_role_status.内力 ~= int_内力 then
    --             G.TweenCom('内力', int_时间, c_combat_role_status, int_内力)
    --         end
    --     end
    -- end
end
function noti.战斗系统_操作面板_更新武功类型(string_武功类型)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if not (c_combat and c_combat.操作面板) then return end
    local c_combat_cpanel = c_combat.操作面板.c_combat_cpanel;
    if not c_combat_cpanel then return end
    --
    for i = 0, c_combat_cpanel.切换武功类型.childCount - 1 do
        local ui = c_combat_cpanel.切换武功类型.getChildAt(i);
        if string_武功类型 == ui.c_handle_click.事件参数一 then
            ui.c_button.state = 'c'
            ui.mouseEnabled = false
        else
            ui.c_button.state = ''
            ui.mouseEnabled = true
        end
    end
end
function noti.战斗系统_操作面板_更新武功状态(o_base_游戏数据,_o_kungfu_可用武功)
    if not o_base_游戏数据 then return end
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if not (c_combat and c_combat.操作面板) then return end
    local c_combat_cpanel = c_combat.操作面板.c_combat_cpanel;
    if not c_combat_cpanel then return end
    --
    local int_集气 = o_base_游戏数据.主角.集气;
    local int_内力 = o_base_游戏数据.主角.内力;
    local o_kungfu_武功 = _o_kungfu_可用武功[1]
    if o_kungfu_武功 then
        if int_集气 >= o_kungfu_武功.需集气 and int_内力 >= o_kungfu_武功.需内力 * o_kungfu_武功.等级 then
            c_combat_cpanel.按钮_攻击.c_button:enable();
            c_combat_cpanel.按钮_攻击.c_handle_click.允许点击事件 = true;
        else
            c_combat_cpanel.按钮_攻击.c_button:disable();
            c_combat_cpanel.按钮_攻击.c_handle_click.允许点击事件 = false;
        end
    end
    for int_i = 1, 6 do
        local ui = c_combat_cpanel['武功' .. int_i]
        o_kungfu_武功 = _o_kungfu_可用武功[int_i + 1]
        if o_kungfu_武功 then
            ui.img = o_kungfu_武功.图标;
            if o_kungfu_武功.需物品 ~= nil then
                ui.getChildAt(0).text = o_kungfu_武功.需物品.数量
                ui.getChildAt(0).visible = true
            else
                ui.getChildAt(0).visible = false
            end
            ui.mouseEnabled = true;
            if int_集气 < o_kungfu_武功.需集气 or int_内力 < o_kungfu_武功.需内力 * o_kungfu_武功.等级 then
                ui.color = 0x808080;
                ui.c_handle_click.允许点击事件 = false;
            else
                ui.color = 0xFFFFFF;
                ui.c_handle_click.允许点击事件 = true;
            end
            ui.c_handle_click.事件参数二 = o_kungfu_武功.name;  ----
        else
            ui.getChildAt(0).visible = false
            ui.img = 0x5601100d;
            ui.color = 0xFFFFFF;
            ui.mouseEnabled = false;
            ui.c_handle_click.允许点击事件 = false;
            ui.c_handle_click.事件参数二 = 0;   ----
        end
    end
    if o_base_游戏数据.对手.允许逃跑 then
        if int_集气 >= 2 then
            c_combat_cpanel.按钮_逃跑.c_button:enable();
            c_combat_cpanel.按钮_逃跑.c_handle_click.允许点击事件 = true;
        else
            c_combat_cpanel.按钮_逃跑.c_button:disable();
            c_combat_cpanel.按钮_逃跑.c_handle_click.允许点击事件 = false;
        end
    end
end

function noti.战斗系统_显示战斗结果(enum_战斗结果_战斗结果)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    G.wait_time(1200);
    if enum_战斗结果_战斗结果 == 1 then 
        c_combat.战斗结果.visible = true;
        c_combat.战斗结果.frameActionID(101);
    elseif enum_战斗结果_战斗结果 == 2 then 
        G.trig_event('战斗系统_显示战斗结果完毕');
        G.trig_event('战斗系统_任意点击继续');
    else
        c_combat.战斗结果.visible = true;
        c_combat.战斗结果.frameActionID(102);
    end
end
function noti.战斗系统_显示战斗对话ui(string_对话)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    c_combat.战斗对话.getChildAt(0).text = string_对话;
    c_combat.战斗对话.visible = true;
end

function noti.战斗系统_显示圆圈(int_坐标X, int_坐标Y, int_宽, int_高, color_颜色)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    c_combat.圆圈.x = int_坐标X;
    c_combat.圆圈.y = int_坐标Y;
    c_combat.圆圈.width = int_宽;
    c_combat.圆圈.height = int_高;
    c_combat.圆圈.color = color_颜色;
    c_combat.圆圈.visible = true;
end

function noti.战斗系统_隐藏圆圈()
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    c_combat.圆圈.visible = false;
end

function noti.战斗系统_对手集气ui(int_需时间)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if c_combat then
        c_combat.气槽.width = 0
        G.Tween('width', int_需时间, c_combat.气槽, 163)
    end
end
function noti.战斗系统_我方集气ui(int_需时间)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if c_combat then
        local c_combat_cpanel = c_combat.操作面板.c_combat_cpanel;
        if c_combat_cpanel then
            c_combat_cpanel.气槽.width = 0
            G.Tween('width', int_需时间, c_combat_cpanel.气槽, 259)
        end
    end
end
function noti.战斗系统_停止对手集气()
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if c_combat then
        c_combat.气槽.width = c_combat.气槽.width
    end
end
function noti.战斗系统_停止我方集气()
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if c_combat then
        local c_combat_cpanel = c_combat.操作面板.c_combat_cpanel;
        if c_combat_cpanel then
            c_combat_cpanel.气槽.width = c_combat_cpanel.气槽.width
        end
    end
end
function noti.战斗系统_播放动作序列(_fargo_fight_model_action_动作序列, boolean_我方)
    G.RunAction('战斗系统_播放动作序列', _fargo_fight_model_action_动作序列, boolean_我方)
end
function noti.战斗系统_播放人物动作ui(boolean_我方行动, int_动作编号)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if not c_combat then return end
    if boolean_我方行动 then
        c_combat.我方.frameActionID(int_动作编号);
    else
        c_combat.对手.frameActionID(int_动作编号);
    end
end
function noti.战斗系统_显示伤害数值(boolean_我方行动, int_数值, color_颜色, int_延时)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if not c_combat then return end
    local ui = G.Clone(c_combat.伤害数值);
    ui.c_bmpfont.text = string.format('%+d', int_数值);
    ui.color = color_颜色;
    if boolean_我方行动 then
        c_combat.我方伤害.addChild(ui);
    else
        c_combat.对手伤害.addChild(ui);
    end
    G.RunAction('战斗系统_伤害数值飘动', ui, int_延时);
end
function noti.战斗系统_显示伤害ui(boolean_我方行动)
    if G.is_editor then
        noti.战斗系统_显示伤害数值(boolean_我方行动, -math.random(1, 9999), 0xFF, 0)
        return
    end
    if true == boolean_我方行动 then
        G.trig_event('战斗_我方伤害结算');
    elseif false == boolean_我方行动 then
        G.trig_event('战斗_对手伤害结算');
    end
end
function noti.战斗系统_播放音效ui(boolean_我方行动, audio_音效)
    G.noti_call('通用_播放音效', audio_音效);
end
function noti.战斗系统_播放光影ui(boolean_我方行动, int_光影编号)
    local ui_obj = G.getUI('v_combat') or G.addUI('v_combat');
    local c_combat = ui_obj.c_combat;
    if not c_combat then return end
    if boolean_我方行动 then
        c_combat.我方特效.visible = true;
        c_combat.我方特效.frameActionID(int_光影编号);
    else
        c_combat.对手特效.visible = true;
        c_combat.对手特效.frameActionID(int_光影编号);
    end
end