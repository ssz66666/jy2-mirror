--[[5003

]]
local G = require "gf"
local t = G.act


--type=private
t['战斗系统_播放动作序列'] = function(_fargo_fight_model_action_动作序列, boolean_我方)
    local fargo_fight_model_action_动作
    local string_函数名
    local int_延时
    if not(_fargo_fight_model_action_动作序列 and type(_fargo_fight_model_action_动作序列) == 'table' and #_fargo_fight_model_action_动作序列 > 0) then
        return
    end
	if G.is_editor then
        G.noti_call('通用_停止音效');
    end
    for i = 1, #_fargo_fight_model_action_动作序列 do
        fargo_fight_model_action_动作 = {}
        G.deepcopy(_fargo_fight_model_action_动作序列[i], fargo_fight_model_action_动作)
        string_函数名 = fargo_fight_model_action_动作[1] .. 'ui'
        int_延时 = fargo_fight_model_action_动作[2]
        if int_延时 ~= nil and int_延时 > 0 then
            G.wait_time(int_延时);
        end
        -- for j, v in ipairs(fargo_fight_model_action_动作) do
        -- for j = 1, 3 do
        --     print('战斗系统_播放动画序列', j, fargo_fight_model_action_动作[j])
        -- end
        G.noti_call(string_函数名, boolean_我方, fargo_fight_model_action_动作[3]);
        -- fargo_fight_model_action_动作[1] = string_函数名
        -- fargo_fight_model_action_动作[2] = boolean_我方
        -- G.noti_call(fargo_fight_model_action_动作);
        -- G.noti_call(string_函数名, boolean_我方, unpack(fargo_fight_model_action_动作, 3));
    end
    -- 以防万一动作序列里面, 没有结算指令
    -- if true == boolean_我方 then
    --     G.trig_event('战斗_我方伤害结算');
    -- elseif false == boolean_我方 then
    --     G.trig_event('战斗_对手伤害结算');
    -- end
end

t['战斗系统_伤害数值飘动'] = function(node, int_延时)
    local int_time = 1000;
    if int_延时 ~= nil and int_延时 > 0 then
        G.wait_time(int_延时);
    end
    node.scaleX = 1.6;
    -- node.scaleY = 1.5;
    node.x = -16;
    node.y = 16;
    node.alpha = 255;
    node.visible = true;
    -- G.Tween('alpha', int_time, node, 0);
    G.Tween('scaleX', int_time / 3, node, 0.6);
    G.Tween('scaleY', int_time / 2, node, 0.6);
    G.Tween('y', int_time, node, 250);
    G.Tween('x', int_time / 3, node, 16);
    -- G.wait_time(int_time);
    G.wait_time(int_time * 0.4);
    G.Tween('alpha', int_time * 0.6, node, 0);
    G.wait_time(int_time * 0.6);
    node.visible = false;
    node.parent.removeChild(node);
end
