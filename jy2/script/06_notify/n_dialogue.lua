local G = require "gf"
local noti = G.notify

function noti.对话系统_显示对话ui(string_姓名, image_头像, string_对白, enum_左右_头像位置)
    local ui_obj
    ui_obj = G.getUI('v_dialogue')
    if not ui_obj then
        ui_obj = G.addUI('v_dialogue')
    end
    local c_dialogue = ui_obj.c_dialogue;
    if c_dialogue then
        if 0 == enum_左右_头像位置 then
            c_dialogue.背景.scaleX = 1;
            c_dialogue.姓名.x = -130;
            c_dialogue.对白.x = -185;
        else
            c_dialogue.背景.scaleX = -1;
            c_dialogue.姓名.x = 130;
            c_dialogue.对白.x = -275;
        end
        c_dialogue.姓名.text = string_姓名;
        c_dialogue.头像.img = image_头像;
        c_dialogue.对白.text = string_对白;
        if true then
            local ui_text = c_dialogue.对白
            ui_text.scaleX = 0.5
            ui_text.y = -133
            ui_text.wrap = true
        end
        c_dialogue.等待.visible = false;
        c_dialogue.对白.visible = true;
        c_dialogue.选项组.visible = false;
    end
    ui_obj.visible = true
end

-- function noti.对话系统_显示对话_结束end()
--     local ui_obj
--     ui_obj = G.getUI('v_dialogue')
--     if ui_obj then
--         ui_obj.visible = false
--     end
-- end


function noti.对话系统_显示选项_待删除(string_姓名, image_头像, string_对白, _string_选项, enum_左右_头像位置)
    local ui_obj
    ui_obj = G.getUI('v_dialogue')
    if not ui_obj then
        ui_obj = G.addUI('v_dialogue')
    end
    local c_dialogue = ui_obj.c_dialogue;
    if c_dialogue then
        if 0 == enum_左右_头像位置 then
            c_dialogue.背景.scaleX = 1;
            c_dialogue.姓名.scaleX = 1;
            c_dialogue.对白.scaleX = 1;
            c_dialogue.选项组.scaleX = 1;
        else
            c_dialogue.背景.scaleX = -1;
            c_dialogue.姓名.scaleX = -1;
            c_dialogue.对白.scaleX = -1;
            c_dialogue.选项组.scaleX = -1;
        end
        c_dialogue.姓名.text = string_姓名;
        c_dialogue.头像.img = image_头像;
        local item_no = #_string_选项
        if string_对白 ~= nil and string_对白 ~= '' then
            c_dialogue.对白.text = string_对白;
            c_dialogue.对白.visible = true;
            c_dialogue.对白.dlgword = 0
            c_dialogue.选项组.y = 8;
        else
            c_dialogue.对白.visible = false;
            c_dialogue.选项组.y = 25;
        end
        c_dialogue.选项组.removeAllChildren();
        if item_no == 3 then
            c_dialogue.选项组.spacing = -2
        elseif item_no > 3 then
            c_dialogue.对白.visible = false;
            c_dialogue.选项组.spacing = -2
            c_dialogue.选项组.y = 30;
        else
            c_dialogue.选项组.spacing = 2
        end
        if item_no >= 5 then
        end
        for i, v in ipairs(_string_选项) do
            local ui = G.Clone(c_dialogue.选项模板);
            ui.name = '选项_' .. i;
            ui.getChildAt(1).text = i .. '.' .. v;
            ui.visible = true;
            c_dialogue.选项组.addChild(ui);
        end
        c_dialogue.选项组.visible = true;
    end
    ui_obj.visible = true
end

function noti.对话系统_显示选项(string_姓名, image_头像, string_对白, _string_选项, enum_左右_头像位置)
    local ui_obj
    ui_obj = G.getUI('v_dialogue')
    if not ui_obj then
        ui_obj = G.addUI('v_dialogue')
    end
    local c_dialogue = ui_obj.c_dialogue;
    if c_dialogue then
        if 0 == enum_左右_头像位置 then
            c_dialogue.背景.scaleX = 1;
            c_dialogue.姓名.x = -130;
            c_dialogue.对白.x = -185;
            c_dialogue.选项组.scaleX = 1;
        else
            c_dialogue.背景.scaleX = -1;
            c_dialogue.姓名.x = 130;
            c_dialogue.对白.x = -275;
            c_dialogue.选项组.scaleX = -1;
        end
        c_dialogue.姓名.text = string_姓名;
        c_dialogue.头像.img = image_头像;
        c_dialogue.等待.visible = false;
        if string_对白 ~= nil and string_对白 ~= '' then
            c_dialogue.对白.text = string_对白;
            if true then
                local ui_text = c_dialogue.对白
                ui_text.y = -133
                ui_text.wrap = false
                ui_text.formatline(0);
                local width = ui_text.TextW;
                if width > 42 * 21 then
                    ui_text.scaleX = 21 * 21 / width
                else
                    ui_text.scaleX = 0.5
                end
            end
            c_dialogue.对白.visible = true;
            c_dialogue.对白.dlgword = 0
            c_dialogue.选项组.y = 0;
            c_dialogue.选项组.height = 50;
        else
            c_dialogue.对白.visible = false;
            c_dialogue.选项组.y = 20;
            c_dialogue.选项组.height = 75;
        end
        c_dialogue.选项组content.removeAllChildren();
        local item_no = 0;
        for i, v in ipairs(_string_选项) do
            if v ~= nil and v ~= '' then
                item_no = item_no + 1;
                local ui = G.Clone(c_dialogue.选项模板);
                local ui_text = ui.getChildAt(1)
                ui.name = '选项_' .. i;
                ui_text.text = item_no .. '.' .. v;
                if true then
                    ui_text.formatline(0);
                    local width = ui_text.TextW;
                    if width > 42 * 21 then
                        ui_text.scaleX = 21 * 21 / width
                    else
                        ui_text.scaleX = 0.5
                    end
                end
                ui.visible = true;
                c_dialogue.选项组content.addChild(ui);
            end
        end
        c_dialogue.选项组content.height = 25 * item_no;
        c_dialogue.选项组content.y = 0
        c_dialogue.选项组.visible = true;
    end
    ui_obj.visible = true
end