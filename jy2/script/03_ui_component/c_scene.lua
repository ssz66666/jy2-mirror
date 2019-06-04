--[[3002

]]

local G = require "gf"
local t = G.com()

function t:init()
    for i, v in ipairs({'背景图片', '主地图地点', '主界面', '跳转', '指令', '序列帧动画', '组件模板', '颜色遮罩'}) do
        self[v] = self.obj.getChildByName(v);
    end
    for i, v in ipairs({'静态头像框', '交互头像框', '按钮_指令', '按钮_跳转', '战斗模型'}) do
        self[v] = self.组件模板.getChildByName(v);
    end
end
function t:onFrameEnd(tar, id)
    if tar == self.序列帧动画 then
        G.trig_event('场景系统_播放序列帧动画_结束');
    end
end
return t