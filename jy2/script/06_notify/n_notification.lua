local G = require "gf"
local noti = G.notify

-- function noti.通知系统_显示系统提示ui(string_提示)
--     local ui_obj
--     ui_obj = G.getUI('v_notification')
--     if not ui_obj then
--         ui_obj = G.addUI('v_notification')
--     end
--     local c_notification = ui_obj.c_notification;
--     if c_notification then
--         c_notification.提示.text = string_提示
--         c_notification.提示框.visible = true
--     end
--     ui_obj.visible = true
-- end
function noti.通知系统_显示系统提示ui(string_标题, string_提示, _string_按钮)
    local ui_obj
    ui_obj = G.getUI('v_notification')
    if not ui_obj then
        ui_obj = G.addUI('v_notification')
    end
    local c_notification = ui_obj.c_notification;
    if c_notification then
        if string_标题 ~= nil and string_标题 ~= '' then
            c_notification.标题.text = string_标题
            c_notification.标题.visible = true
        else
            c_notification.标题.visible = false
        end
        c_notification.提示.text = string_提示
        if _string_按钮 ~= nil and #_string_按钮 > 0 then
            c_notification.按钮组.removeAllChildren()
            for k, v in ipairs(_string_按钮) do
                local ui = G.Clone(c_notification.按钮模板)
                ui.name = v
                ui.c_button.text = v
                ui.visible = true
                c_notification.按钮组.addChild(ui)
            end
            c_notification.等待.visible = false
            c_notification.按钮组.visible = true
        else
            c_notification.等待.visible = true
            c_notification.按钮组.visible = false
        end
        c_notification.提示框.visible = true
    end
    ui_obj.visible = true
end
function noti.通知系统_显示全屏字幕ui(string_字幕, int_滚动时间)
    local ui_obj
    ui_obj = G.getUI('v_notification')
    if not ui_obj then
        ui_obj = G.addUI('v_notification')
    end
    local c_notification = ui_obj.c_notification;
    if c_notification then
        if int_滚动时间 == nil or int_滚动时间 <= 0 then
            int_滚动时间 = 10000
        end
        c_notification.全屏字幕等待.visible = false;
        c_notification.全屏字幕文本.y = -240;
        c_notification.全屏字幕文本.text = string_字幕;
        c_notification.全屏字幕.visible = true
        ui_obj.visible = true
        G.Tween('y', int_滚动时间, c_notification.全屏字幕文本, 200);
        G.wait_time(int_滚动时间);
        c_notification.全屏字幕等待.visible = true;
    end
end
function noti.通知系统_显示输入框(string_标题, int_限制字数)
    local ui_obj
    ui_obj = G.getUI('v_notification')
    if not ui_obj then
        ui_obj = G.addUI('v_notification')
    end
    local c_notification = ui_obj.c_notification;
    if c_notification then
        c_notification.输入框标题.text = string_标题 or '';
        c_notification.输入框输入.text = '';
        c_notification.输入框字数限制 = int_限制字数 or 5;
        c_notification.输入框.visible = true;
    end
    ui_obj.visible = true
end
function noti.通知系统_显示飘字(string_提示, audio_音频, color_颜色, estr_通知飘字位置_位置, int_延时)
    local ui_obj
    ui_obj = G.getUI('v_notification')
    if not ui_obj then
        ui_obj = G.addUI('v_notification')
    end
    local c_notification = ui_obj.c_notification;
    if c_notification then
        local ui = G.Clone(c_notification.飘字)
        ui.text = string_提示;
        if color_颜色 ~= nil then
            ui.color = color_颜色;
        end
        local pos = c_notification[estr_通知飘字位置_位置];
        if pos == nil then
            pos = c_notification.右下
        end
        pos.addChild(ui);
        G.RunAction('通知系统_显示飘字', ui, audio_音频, int_延时)
    end
    ui_obj.visible = true
end
function noti.通知系统_显示等级上升(audio_音频, int_延时)
    local ui_obj
    ui_obj = G.getUI('v_notification')
    if not ui_obj then
        ui_obj = G.addUI('v_notification')
    end
    local c_notification = ui_obj.c_notification;
    if c_notification then
        local ui = G.Clone(c_notification.等级上升)
        c_notification.右上.addChild(ui);
        G.RunAction('通知系统_显示飘字', ui, audio_音频, int_延时)
    end
    ui_obj.visible = true
end

-- function noti.通知系统_显示系统提示_结束end()
--     local ui_obj
--     ui_obj = G.getUI('v_notification')
--     if ui_obj then
--         ui_obj.visible = false
--     end
-- end