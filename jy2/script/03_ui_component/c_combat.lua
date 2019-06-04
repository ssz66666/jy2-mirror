--[[3003

]]

local G = require "gf"
local t = G.com()

function t:init()
    for i, v in ipairs({'战场', '对手状态', '我方状态', '气槽', '武功名称', '操作面板', '伤害数值', '战斗对话', '圆圈','战斗结果'}) do
        self[v] = self.obj.getChildByName(v);
    end
    for i, v in ipairs({'对手', '我方', '对手特效', '我方特效', '对手伤害', '我方伤害'}) do
        self[v] = self.战场.getChildByName(v);
    end
    if G.is_editor then
        self.对手.frameActionID(100);
    else
        self.obj.visible = false;
    end
end

function t:click(tar)
    if self.战斗对话.visible then
        G.trig_event('战斗系统_显示战斗对话_结束')
        self.战斗对话.visible = false;
    else
        G.trig_event('战斗系统_任意点击继续')
    end
    -- print('c_combat t:click', tar)
end

function t:onFrameEnd(tar, id)
    if tar == self.我方 then
        G.trig_event('战斗_我方行动完毕');
        if G.is_editor then
            tar.frameActionID(0);
        end
    elseif tar == self.对手 then
        G.trig_event('战斗_对手行动完毕');
        -- if G.is_editor then
            -- print('战斗_对手行动完毕', id)
            -- tar.frameActionID(100 * math.floor(tonumber(id) / 100));
        -- end
    elseif tar == self.战斗结果 then
        G.trig_event('战斗系统_显示战斗结果完毕');
    else
        tar.visible = false;
    end
end
return t