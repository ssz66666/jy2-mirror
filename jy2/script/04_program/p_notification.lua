--[[4001

]]
local G = require "gf"
local L = {}
local t = G.api
--type=通知系统
--hide=true
--private=false
--text=<03>【显示提示】[var:1]
t['通知系统_显示系统提示'] = function(string_提示, string_标题)
    if string_标题 == nil then
        string_标题 =  '提示！！'
    end
    G.call('通知系统_显示系统提示ui', string_标题, string_提示, nil)
    G.call("通用_等待事件", "通知系统_显示系统提示_结束")
end
--type=通知系统
--hide=true
--private=false
--text=<03>【显示提示并等待确定】[var:1]
t['通知系统_显示系统提示并等待确定'] = function(string_提示, string_标题)
    G.call('通知系统_显示系统提示ui', string_标题, string_提示, {'确定'})
    G.call("通用_等待事件", "通知系统_显示系统提示_结束")
end
--type=通知系统
--ret=boolean
--hide=true
--private=false
--text=<03>【显示提示并等待选择】[var:1]
t['通知系统_显示系统提示并等待选择'] = function(string_提示)
    local string_选择结果
    G.call('通知系统_显示系统提示ui', nil, string_提示, {'确定', '取消'})
    string_选择结果 = G.call("通用_等待事件", "通知系统_显示系统提示_结束")
    if string_选择结果 == '确定' then
        return true
    else
        return false
    end
end
--type=通知系统
--hide=true
--private=false
--ret=string
--text=<03>【等待输入】[var:1]
t['通知系统_显示输入框并等待'] = function(string_标题, int_限制字数)
    local string_输入 = ''
    G.call('通知系统_显示输入框', string_标题, int_限制字数)
    string_输入 = G.call("通用_等待事件", "通知系统_显示输入框_结束")
    return string_输入
end
--type=通知系统
--hide=true
--private=false
--text=<03>【显示全屏字幕】[var:1]
t['通知系统_显示全屏字幕'] = function(string_字幕, int_滚动时间)
    G.call('通知系统_显示全屏字幕ui', string_字幕, int_滚动时间)
    G.call("通用_等待事件", "通知系统_显示全屏字幕_结束")
end
--type=通知系统
--hide=true
--private=false
--text=<03>【显示提示】[var:1]
t['通知系统_显示飘字'] = function(string_提示, audio_音频, color_颜色, estr_通知飘字位置_位置, int_延时)
    
end
--type=通知系统
--hide=true
--private=false
--text=<03>【显示提示】显示等级上升
t['通知系统_显示等级上升'] = function(audio_音频, int_延时)
    
end