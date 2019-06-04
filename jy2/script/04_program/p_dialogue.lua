--[[4001

]]
local G = require "gf"
local t = G.api
local L = {}
--type=对话系统
--hide=true
--private=true
--ret=_string
--text=<03>将对话文本分段,每段[var:2]行,每行[var:3]字, 以[var:4]换行
t['对话系统_文本分段'] = function(string_对白, int_行数, int_每行字数, string_换行符)
    --[[
    UTF8的编码规则：
    1. 字符的第一个字节范围： 0x00—0x7F(0-127),或者 0xC2—0xF4(194-244); UTF8 是兼容 ascii 的，所以 0~127 就和 ascii 完全一致
    2. 0xC0, 0xC1,0xF5—0xFF(192, 193 和 245-255)不会出现在UTF8编码中 
    3. 0x80—0xBF(128-191)只会出现在第二个及随后的编码中(针对多字节编码，如汉字) 
    ]]
    local text = string_对白;
    local utfTb = {};
    local sentenceTb = {};
    local sentence = '';
    local length = 0;
    local row = 0;
    local inCtrl = false;
    local ctrlText = ''
    if string_换行符 ~= nil and string_换行符 ~= '[br]' then
        text = string.gsub(text, string_换行符, '[br]');
    end
    for utfChar in string.gmatch(text, "[%z\1-\127\194-\244][\128-\191]*") do
        table.insert(utfTb, utfChar);
    end
    for i, s in ipairs(utfTb) do
        local len = 0;
        if s == '[' then
            inCtrl = true;
            ctrlText = s;
        elseif s == ']' then
            inCtrl = false;
            ctrlText = ctrlText .. s;
            if ctrlText == '[br]' then
                length = 0;
                row = row + 1;
                if row >= int_行数 then
                    length = 0;
                    row = 0;
                    table.insert(sentenceTb, sentence);
                    s = '';
                    sentence = '';
                else
                    sentence = sentence .. ctrlText;
                end
            else
                sentence = sentence .. ctrlText;
            end
        elseif inCtrl then
            ctrlText = ctrlText .. s;
        else
            if #s > 1 then
                len = 1;
            else
                len = 0.5;
            end
            if length + len > int_每行字数 then
                row = row + 1;
                length = len;
                if row >= int_行数 then
                    row = 0;
                    table.insert(sentenceTb, sentence);
                    sentence = s;
                else
                    sentence = sentence .. '[br]' .. s;
                end
            else
                length = length + len;
                sentence = sentence .. s;
            end
        end
    end
    if #sentence > 0 then
        table.insert(sentenceTb, sentence);
    end
    return sentenceTb
end
--type=对话系统
--hide=false
--private=false
--text=<03>【显示对话】[var:1][var:2]: "[var:3]"
t['对话系统_显示对话'] = function(string_姓名, image_头像, string_对白, int_翻转)
    local _string_对白 = G.call('对话系统_文本分段', string_对白, 3, 21)
    local int_段落总数 = #_string_对白
    for int_i = 1, int_段落总数, 1 do
        G.call('对话系统_显示对话ui', string_姓名, image_头像, _string_对白[int_i], int_翻转)
        G.call("通用_等待事件", "对话系统_显示对话_结束")
    end
end
--type=对话系统
--hide=false
--private=false
--text=<03>【显示对话】主角: "[var:1]"
t['对话系统_显示主角对话'] = function(string_对白)
	local o_base_游戏数据 = G.QueryName(0x10050001)
    local o_role_主角 = o_base_游戏数据.主角
    string_对白 = G.call('通用_处理转意字符', string_对白)
    G.call('对话系统_显示对话', o_role_主角.姓名, o_role_主角.头像, string_对白, 0)
end
--type=对话系统
--hide=false
--private=false
--text=<03>【显示对话】[var:1][var:2]: "[var:3]"
t['对话系统_显示NPC对话'] = function(string_姓名,image_头像,string_对白)
    string_姓名 = G.call('通用_处理转意字符', string_姓名)
    string_对白 = G.call('通用_处理转意字符', string_对白)
    G.call('对话系统_显示对话', string_姓名, image_头像, string_对白, 1)
end
--type=对话系统
--hide=false
--private=false
--text=<03>【显示随机对话】[var:1][var:2]: "[var:3]"
t['对话系统_显示NPC随机对话'] = function(string_姓名,image_头像,_string_对白)
    local int_对话数量 = #_string_对白
    local int_随机编号 = G.call('运算_随机数', 1, int_对话数量);
    local string_对白 = _string_对白[int_随机编号]
    if string_对白 ~= nil then
        G.call('对话系统_显示NPC对话', string_姓名, image_头像, string_对白)
    end
end
--type=对话系统
--hide=true
--private=false
--ret=int
--text=<03>【显示选项】主角: "[var:1], [var:2]"
t['对话系统_显示主角选项'] = function(string_对白,_string_选项)
	local o_base_游戏数据 = G.QueryName(0x10050001)
	local o_role_主角 = o_base_游戏数据.主角
    local int_选项数量 = #_string_选项
    string_对白 = G.call('通用_处理转意字符', string_对白)
    for int_i = 1, int_选项数量, 1 do
        _string_选项[int_i] = G.call('通用_处理转意字符', _string_选项[int_i])
    end
    G.call('对话系统_显示选项', o_role_主角.姓名, o_role_主角.头像, string_对白, _string_选项,0)
    return G.call("通用_等待事件", "对话系统_显示选项_结束")
end

--type=对话系统
--hide=true
--private=false
--ret=int
--text=<03>【显示选项】[var:1][var:2]: "[var:3], [var:4]"
t['对话系统_显示NPC选项'] = function(string_姓名,image_头像,string_对白, _string_选项)
    local int_选项数量 = #_string_选项
    string_姓名 = G.call('通用_处理转意字符', string_姓名)
    string_对白 = G.call('通用_处理转意字符', string_对白)
    for int_i = 1, int_选项数量, 1 do
        _string_选项[int_i] = G.call('通用_处理转意字符', _string_选项[int_i])
    end
    G.call('对话系统_显示选项', string_姓名, image_头像, string_对白, _string_选项,1)
    return G.call("通用_等待事件", "对话系统_显示选项_结束")
end