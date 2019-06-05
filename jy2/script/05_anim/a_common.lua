--[[5001

]]

local G = require "gf"
local t = G.act

--type=private
t['通用_延时触发事件'] = function(int_延时, ...)
    if int_延时 ~= nil and int_延时 > 0 then
        G.wait_time(int_延时);
    end
    G.trig_event(...);
end
--type=private
t['通用_开始菜单动画'] = function(node)
    local c_game_start = node.c_game_start;
    if not c_game_start then return end
    node.color = 0x0;
    node.visible = true;
    G.call('通用_播放音乐', 0x49000028)
    for i, v in ipairs({'背景', '标题', '副标题', '目录', '云左', '云右', '菜单', '调整属性'}) do
    -- for i, v in ipairs({'背景', '标题', '副标题', '目录', '云左', '云右', '菜单'}) do
        c_game_start[v].visible = false;
    end
    c_game_start.背景.visible = true;
    G.Tween('color', 1000, node, 0xFFFFFF);
    G.wait_time(1200);
    G.call('通用_播放音效', 0x4900000f)
    c_game_start.标题.visible = true;
    c_game_start.标题.frameActionID(0);
    G.wait_time(1200);
    c_game_start.云左.x = -700;
    c_game_start.云右.x = 900;
    c_game_start.云左.visible = true;
    c_game_start.云右.visible = true;
    G.Tween('x', 15000, c_game_start.云左, 700);
    G.Tween('x', 15000, c_game_start.云右, -900);
    c_game_start.目录.visible = true;
    c_game_start.目录.frameActionID(0);
    G.wait_time(700);
    local ox = c_game_start.副标题.x
    c_game_start.副标题.alpha = 0;
    c_game_start.副标题.x = ox + 256;
    G.Tween('alpha', 100, c_game_start.副标题, 255);
    G.Tween('x', 200, c_game_start.副标题, 105);
    c_game_start.菜单.alpha = 0;
    G.Tween('alpha', 300, c_game_start.菜单, 255);
    c_game_start.副标题.visible = true;
    c_game_start.菜单.visible = true;
    G.wait_time(300);
    G.wait_time(14000);
    while node.visible do
        c_game_start.云左.x = -700;
        c_game_start.云右.x = 900;
        G.Tween('x', 15000, c_game_start.云左, 700);
        G.Tween('x', 15000, c_game_start.云右, -900);
        G.wait_time(15000);
    end
end
--type=private
t['通用_结束菜单动画'] = function(node)
    local ui = {};
    for k, v in ipairs({'十年生死', '不思量', '自难忘', '千里孤坟', '重新开始'}) do
        ui[k] = node.getChildByName(v);
        if ui[k] then
            ui[k].visible = false;
        end
    end
    node.alpha = 0;
    node.visible = true;
    G.Tween('alpha', 1500, node, 255)
    G.wait_time(1500);
    node.alpha = 255;
    for i = 1, 5 do
        local sub_ui = ui[i];
        if sub_ui then
            sub_ui.alpha = 0;
            sub_ui.visible = true;
            G.Tween('alpha', 800, sub_ui, 255)
            G.wait_time(600);
        end
    end
    G.wait_time(200);
    for i = 1, 5 do
        local sub_ui = ui[i];
        if sub_ui then
            sub_ui.alpha = 255;
            sub_ui.visible = true;
        end
    end
end
--type=private
t['通知系统_显示飘字'] = function(node, audio_音频, int_延时)
    local int_time = 1200;
    if int_延时 ~= nil and int_延时 > 0 then
        G.wait_time(int_延时);
    end
    node.visible = true;
    node.alpha = 64
    node.x = 0;
    node.y = -16;
    node.scaleY = 0.5
    G.Tween('alpha', 200, node, 255);
    G.wait_time(250);
    if audio_音频 ~= nil then
        G.call('通用_播放音效', audio_音频)
    end
    G.Tween('y', int_time, node, 64);
    G.wait_time(int_time * 0.6);
    G.Tween('scaleY', int_time * 0.4, node, 0.25);
    G.Tween('alpha', int_time * 0.4, node, 64);
    G.wait_time(int_time * 0.4);
    node.visible = false;
    node.parent.removeChild(node);
end
--type=private
t['通用_播放动画序列'] = function(o_common_actionlist_序列,o_node_主体)
    local o_common_tap_动画
    local farg_动画函数
    if not(o_common_actionlist_序列 and o_node_主体 and type(o_common_actionlist_序列.动画) == 'table' and #o_common_actionlist_序列.动画 > 0) then
        return
    end
    for i = 1, #o_common_actionlist_序列.动画 do
        o_common_tap_动画 = o_common_actionlist_序列.动画[i]
        if o_common_tap_动画.动画 then
            farg_动画函数 = {}
            G.deepcopy(o_common_tap_动画.动画, farg_动画函数, {})
            -- 将 o_node_主体作为第一个参数传递
            table.insert(farg_动画函数, 2, o_node_主体)
            -- 延迟作为最后一个参数传递
            farg_动画函数[farg_动画函数.n + 3] = o_common_tap_动画.延迟时间
            farg_动画函数.n = farg_动画函数.n + 2
            if o_common_tap_动画.并行播放 then
                G.RunAction(farg_动画函数)
            else
                G.CallAction(farg_动画函数)
            end
        end
    end
end


--hide=true
--private=false
t['通用_图片震动'] = function(o_node_主体,int_振幅, number_持续时间,number_延迟)
    number_延迟 = number_延迟 or 0
    G.shake(o_node_主体, int_振幅, number_持续时间 * 1000)
    G.wait_time((number_延迟+number_持续时间)*1000)
end

--hide=true
--private=false
t['通用_图片移动'] = function(o_node_主体,o_vector_起始位置,o_vector_结束位置,number_持续时间,number_延迟)
    number_延迟 = number_延迟 or 0
    if not o_vector_结束位置 then o_vector_结束位置 = {} end
    o_vector_结束位置.x = o_vector_结束位置.x or o_node_主体.x
    o_vector_结束位置.y = o_vector_结束位置.y or o_node_主体.y
    if o_vector_起始位置 then
        o_node_主体.x = o_vector_起始位置.x or o_node_主体.x
        o_node_主体.y = o_vector_起始位置.y or o_node_主体.y
    end
    G.Tween("x",number_持续时间 * 1000,o_node_主体,o_vector_结束位置.x)
    G.Tween("y",number_持续时间 * 1000,o_node_主体,o_vector_结束位置.y)
    G.wait_time((number_延迟+number_持续时间)*1000)
end

--hide=true
--private=false
t['通用_图片透明度变化'] = function(o_node_主体,percent_起始透明度,percent_结束透明度,number_持续时间,number_延迟)
    number_延迟 = number_延迟 or 0
    o_node_主体.alpha = (1 - percent_起始透明度) * 255
    G.Tween("alpha",number_持续时间 * 1000,o_node_主体, (1 - percent_结束透明度) * 255)
    G.wait_time((number_延迟+number_持续时间)*1000)
end

--hide=true
--private=false
t['通用_图片颜色变化'] = function(o_node_主体,color_起始颜色,color_结束颜色,number_持续时间,number_延迟)
    number_延迟 = number_延迟 or 0
    o_node_主体.color = color_起始颜色
    G.Tween("color",number_持续时间 * 1000,o_node_主体, color_结束颜色)
    G.wait_time((number_延迟+number_持续时间)*1000)
end

--hide=true
--private=false
t['通用_图片X轴压缩'] = function(o_node_主体,number_起始比例,number_结束比例,number_持续时间,number_延迟)
    number_延迟 = number_延迟 or 0
    o_node_主体.scaleX = number_起始比例
    G.Tween("scaleX",number_持续时间 * 1000,o_node_主体, number_结束比例)
    G.wait_time((number_延迟+number_持续时间)*1000)
end