local G = require "gf"
local noti = G.notify

function noti.init()
end

----
function noti.通用_显示开始菜单()
    local ui_obj = G.getUI('v_game_start') or G.addUI('v_game_start');
    ui_obj.color = 0x0;
    ui_obj.visible = true;
    G.RunAction("通用_开始菜单动画", ui_obj)
end

function noti.通用_关闭开始菜单()
    local ui_obj = G.getUI('v_game_start');
    if ui_obj then
        G.Tween('color', 800, ui_obj, 0);
        G.wait_time(1000);
        ui_obj.visible = false;
    end
end

function noti.通用_显示结束菜单()
    local ui_obj = G.getUI('v_game_over') or G.addUI('v_game_over');
    ui_obj.visible = false;
    G.RunAction("通用_结束菜单动画", ui_obj)
end

function noti.通用_关闭结束菜单()
    local ui_obj = G.getUI('v_game_over');
    if ui_obj then
        G.Tween('color', 800, ui_obj, 0);
        G.wait_time(1000);
        ui_obj.visible = false;
    end
end

function noti.通用_显示调整属性界面(o_role_主角)
    local ui_obj = G.getUI('v_game_start') or G.addUI('v_game_start');
    local c_game_start = ui_obj.c_game_start;
    if c_game_start then
        c_game_start:显示调整属性界面(o_role_主角)
    end
end

function noti.通用_显示公告()
    local ui_obj = G.addUI('v_bulletin')
    local c_bulletin = ui_obj.c_bulletin;
    if c_bulletin then
        c_bulletin:setData('https://action.17m3.com/mjh/j3/')
    end
end

function noti.通用_关闭公告()
    G.removeUI('v_bulletin')
end

function noti.通用_关闭所有界面()
	local ui_obj = G.getUI('v_mainpanel') or G.addUI('v_mainpanel');
    local c_mainpanel = ui_obj.c_mainpanel;
    if c_mainpanel ~= nil then
        c_mainpanel.透明遮挡.visible = false
		c_mainpanel.人物界面.visible = false;
		c_mainpanel.武功界面.visible = false;
		c_mainpanel.物品界面.visible = false;
		c_mainpanel.秘籍界面.visible = false;
	end
end

function noti.通用_显示人物界面()
    local ui_obj = G.getUI('v_mainpanel') or G.addUI('v_mainpanel');
    local c_mainpanel = ui_obj.c_mainpanel;
    local c_mainpanel_role = c_mainpanel.人物界面.c_mainpanel_role;
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
	if c_mainpanel ~= nil then
        c_mainpanel.透明遮挡.visible = true;
		-- c_mainpanel.人物界面.visible = false;
		c_mainpanel.武功界面.visible = false;
		c_mainpanel.物品界面.visible = false;
		c_mainpanel.秘籍界面.visible = false;
		c_mainpanel_role:setData(o_role_主角);
	end
end

function noti.通用_显示武功界面(_o_kungfu_武功)
    local ui_obj = G.getUI('v_mainpanel') or G.addUI('v_mainpanel');
    local c_mainpanel = ui_obj.c_mainpanel;
    local c_mainpanel_kungfu = c_mainpanel.武功界面.c_mainpanel_kungfu;
    for i = 1, 6 do
        local ui = c_mainpanel_kungfu.列表.getChildAt(i - 1);
        local o_kungfu_武功 = _o_kungfu_武功[i];
        if o_kungfu_武功 and o_kungfu_武功.等级 > 0 then
            ui.getChildAt(0).img = o_kungfu_武功.图标;
            ui.getChildAt(1).text = o_kungfu_武功.名称;
            ui.getChildAt(2).text = o_kungfu_武功.等级 .. '';
            ui.getChildAt(1).visible = true;
            ui.getChildAt(2).visible = true;
        else
            ui.getChildAt(0).img = 0x5601100d;
            ui.getChildAt(1).visible = false;
            ui.getChildAt(2).visible = false;
        end
    end
    c_mainpanel.透明遮挡.visible = true;
	c_mainpanel.人物界面.visible = false;
	-- c_mainpanel.武功界面.visible = false;
	c_mainpanel.物品界面.visible = false;
	c_mainpanel.秘籍界面.visible = false;
    c_mainpanel.武功界面.visible = true;
end

function noti.通用_显示物品界面(enum_物品类型_类型)
    if enum_物品类型_类型 == 3 then
        noti.通用_显示秘籍();
        return;
    end
    local ui_obj = G.getUI('v_mainpanel') or G.addUI('v_mainpanel');
    local c_mainpanel = ui_obj.c_mainpanel;
    local c_mainpanel_item = c_mainpanel.物品界面.c_mainpanel_item;
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
    local uid = 0x10060000 + 16 * enum_物品类型_类型;
    for i = 1, 16 do
        local o_item_物品 = G.QueryName(uid + i);
        local ui = c_mainpanel_item.网格.getChildAt(i - 1);
        ui.visible = false;
        if o_item_物品 and o_item_物品.数量 > 0 then
            ui.img = o_item_物品.图标;
            local subui = ui.getChildAt(0);
            subui.text = o_item_物品.名称;
            subui.scaleX = math.min(1, 10.5/#o_item_物品.名称) / 2;
            subui = ui.getChildAt(1);
            if 1 == enum_物品类型_类型 then
                subui.text = o_item_物品.数量 .. '';
                subui.visible = true;
            elseif 0 == enum_物品类型_类型 then
                if o_item_物品 == o_role_主角.武器 then
                    subui.text = '武';
                    subui.visible = true;
                elseif o_item_物品 == o_role_主角.防具 then
                    subui.text = '防';
                    subui.visible = true;
                else
                    subui.visible = false;
                end
            else
                subui.visible = false;
            end
            if ui.c_handle_click then
                ui.c_handle_click.事件参数二 = uid + i
            end
            ui.visible = true;
        end
    end
    if 0 == enum_物品类型_类型 then
        c_mainpanel_item.说明.text = '点击图片进行装备';
        c_mainpanel_item.说明.visible = true;
        c_mainpanel_item.卸兵.visible = true;
        c_mainpanel_item.卸甲.visible = true;
    elseif 1 == enum_物品类型_类型 then
        c_mainpanel_item.说明.text = '点击图片服用丹药';
        c_mainpanel_item.说明.visible = true;
        c_mainpanel_item.卸兵.visible = false;
        c_mainpanel_item.卸甲.visible = false;
    else
        c_mainpanel_item.说明.visible = false;
        c_mainpanel_item.卸兵.visible = false;
        c_mainpanel_item.卸甲.visible = false;
    end
    c_mainpanel.透明遮挡.visible = true;
	c_mainpanel.人物界面.visible = false;
	c_mainpanel.武功界面.visible = false;
	-- c_mainpanel.物品界面.visible = false;
	c_mainpanel.秘籍界面.visible = false;
    c_mainpanel.物品界面.visible = true;
end

function noti.通用_显示秘籍界面()
    local enum_物品类型_类型 = 3;
	local o_base_游戏数据 = G.QueryName(0x10050001)
    local o_role_主角 = o_base_游戏数据.主角
    local int_学点 = o_role_主角.学点;
    local ui_obj = G.getUI('v_mainpanel') or G.addUI('v_mainpanel');
    local c_mainpanel = ui_obj.c_mainpanel;
    local c_mainpanel_item_scripture = c_mainpanel.秘籍界面.c_mainpanel_item_scripture;
    local uid = 0x10060000 + 16 * enum_物品类型_类型;
    for i = 1, 16 do
        local o_item_物品 = G.QueryName(uid + i);
        local ui = c_mainpanel_item_scripture.网格.getChildAt(i - 1);
        ui.visible = false;
        if o_item_物品 and o_item_物品.数量 > 0 then
            ui.img = o_item_物品.图标;
            local subui = ui.getChildAt(0);
            subui.text = o_item_物品.名称;
            subui.scaleX = math.min(1, 12/#o_item_物品.名称) / 2;
            subui = ui.getChildAt(1);
            subui.img = 0x56010085 + math.max(0, math.min(5, o_item_物品.修炼层数));
            ui.visible = true;
        end
        if ui.c_handle_click then
            ui.c_handle_click.事件参数二 = uid + i
        end
    end
    if int_学点 ~= nil then
        c_mainpanel_item_scripture.学点.text = int_学点 .. '';
    end
    c_mainpanel.透明遮挡.visible = true;
	c_mainpanel.人物界面.visible = false;
	c_mainpanel.武功界面.visible = false;
	c_mainpanel.物品界面.visible = false;
	-- c_mainpanel.秘籍界面.visible = false;
    c_mainpanel.秘籍界面.visible = true;
end
function noti.通用_显示读档界面()
    local ui_obj = G.getUI('v_mainpanel') or G.addUI('v_mainpanel');
    local c_mainpanel = ui_obj.c_mainpanel;
    local c_mainpanel_save = c_mainpanel.存档界面.c_mainpanel_save;
    c_mainpanel.透明遮挡.visible = true;
    c_mainpanel_save:显示读档界面()
end
function noti.通用_显示存档界面()
    local ui_obj = G.getUI('v_mainpanel') or G.addUI('v_mainpanel');
    local c_mainpanel = ui_obj.c_mainpanel;
    local c_mainpanel_save = c_mainpanel.存档界面.c_mainpanel_save;
    c_mainpanel.透明遮挡.visible = true;
    c_mainpanel_save:显示存档界面()
end
function noti.通用_显示商店界面(int_银两, _string_商品)
    local ui_obj
    ui_obj = G.getUI('v_grocery')
    if not ui_obj then
        ui_obj = G.addUI('v_grocery')
    end
    local c_grocery = ui_obj.c_grocery;
    if c_grocery then
        c_grocery.银两.text = int_银两 .. '';
        c_grocery.列表content.removeAllChildren();
        local item_no = 0;
        for i, string_商品 in ipairs(_string_商品) do
            if string_商品 ~= nil and string_商品 ~= '' then
                item_no = item_no + 1;
                local ui = G.Clone(c_grocery.选项模板);
                ui.name = '选项_' .. i;
                local n = 1;
                string.gsub(string_商品, "[^|]+", function(s)
                    ui.getChildAt(n).text = s;
                    n = n + 1;
                end, 3);
                ui.visible = true;
                c_grocery.列表content.addChild(ui);
            end
        end
        c_grocery.列表content.height = 22 * item_no
        c_grocery.列表content.y = 0
    end
    ui_obj.visible = true
end
function noti.通用_播放音乐(audio_音乐)
	if G.misc().当前背景音乐 == audio_音乐 then
		return;
	end
	G.misc().当前背景音乐 = audio_音乐;
	if audio_音乐 then
		local boolean_结果 = G.Play(audio_音乐, 1, true, 0, 0);
	end
end
function noti.通用_播放音效(audio_音效)
	local int_通道 = G.misc().当前音效通道;
	if int_通道 then
		int_通道 = int_通道 + 1;
		if int_通道 > 10 then
			int_通道 = 1;
		end
	else
		int_通道 = 1;
	end
	G.misc().当前音效通道 = int_通道;
	if audio_音效 then
		local boolean_结果 = G.Play(audio_音效, 1, false, int_通道, 0);
	end
end
function noti.通用_停止音乐()
	G.Stop(0, 1000);
end
function noti.通用_停止音效()
    for int_通道 = 1, 10 do
        G.Stop(int_通道, 0);
    end
end
function noti.通用_停止所有声音()
    for int_通道 = 0, 10 do
        G.Stop(int_通道, 0);
    end
end