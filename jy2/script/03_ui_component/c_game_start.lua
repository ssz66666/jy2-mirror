--[[300c

]]

local G = require "gf"
local t = G.com()
function t:init()
    for i, v in ipairs({'背景', '标题', '副标题', '目录', '云左', '云右', '菜单', '调整属性'}) do
        self[v] = self.obj.getChildByName(v);
    end
    if not G.is_editor then
        self.obj.visible = false;
        for i, v in ipairs({'姓名_姓', '姓名_名', '头像', '属性', '头像列表', '选择头像', '随机属性', '确定属性'}) do
            self[v] = self.调整属性.getChildByName(v);
        end
        self.头像列表content = self.头像列表.getChildByName('列表').getChildByName('content')
        local ui = self.头像列表content.getChildAt(0);
        self.头像列表content.removeAllChildren();
        for id = 1, 98 do
            local ui_clone = G.Clone(ui)
            ui_clone.name = '' .. id
            ui_clone.getChildAt(1).img = 0x56020000 + id
            ui_clone.getChildAt(1).color = 0x808080
            self.头像列表content.addChild(ui_clone)
        end
        self.头像列表content.height = 85 * math.ceil(98 / 6) - 1
        self.头像列表content.y = 0;
    end
end
function t:显示调整属性界面(o_role_主角)
    self.调整属性.visible = true;
    -- self.姓名_姓.text = o_role_主角.姓;
    -- self.姓名_名.text = o_role_主角.名;
    if self.头像.img ~= o_role_主角.头像 then
        self.头像.img = o_role_主角.头像;
        self.头像列表content.y = 0;
    end
    for k, v in ipairs({'生命', '内力', '力道', '护体', '身法', '医疗', '用毒', '解毒', '拳掌', '御剑', '暗器', '悟性'}) do
        self.属性.getChildAt(k - 1).text = '' .. o_role_主角[v];
    end
end
--ret=string
function t:cutString()
    local string_name = self.姓名_姓.text
    if G.getStrLen(string_name) > 2 then
        local string_cut = G.utf8sub(string_name,1,2)
        self.姓名_姓.text = string_cut
    end
    string_name = self.姓名_名.text
    if G.getStrLen(string_name) > 2 then
        local string_cut = G.utf8sub(string_name,1,2)
        self.姓名_名.text = string_cut
    end
end
function t:rollOver(tar)
    if tar.parent == self.头像列表content then
        tar.getChildAt(0).visible = true;
        tar.getChildAt(1).color = 0xFFFFFF
    end
end
function t:rollOut(tar)
    if tar.parent == self.头像列表content then
        tar.getChildAt(0).visible = false;
        tar.getChildAt(1).color = 0x808080
    end
end
function t:click(tar)
    if tar.parent == self.头像列表content then
        self.头像列表.visible = false;
        local id = tonumber(tar.name)
        if id ~= nil then
            id = 0x56020000 + id;
            self.头像.img = id;
            G.trig_event("通用_UI交互", "更改头像", id)
        end
    elseif tar == self.选择头像 then
        self.头像列表.visible = true;
    elseif tar == self.确定属性 then
        G.trig_event("通用_UI交互", "确定属性", self.姓名_姓.text, self.姓名_名.text)
    end
end
function t:update()
    if not G.is_editor then
        self:cutString();
    end
end
return t