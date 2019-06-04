--[[3006

]]

local G = require "gf"
local t = G.com()

function t:init()
    for i, v in ipairs({'气槽', '按钮_查看属性', '按钮_逃跑', '按钮_切换', '按钮_攻击', '切换武功类型', '选择武功'}) do
        self[v] = self.obj.getChildByName(v);
    end
    for i, v in ipairs({'按钮_拳', '按钮_掌', '按钮_指', '按钮_剑', '按钮_内'}) do
        self[v] = self.切换武功类型.getChildByName(v);
    end
    for i = 1, 6 do
        self['武功' .. i] = self.选择武功.getChildByName('武功' .. i);
    end
    ----------------
    self.武功属性 = self.obj.getChildByName('武功属性');
    self.武功属性.visible = false;
end
function t:开启(boolean_允许逃跑)
    self.气槽.width = 0;
    self.按钮_查看属性.visible = true
    self.按钮_逃跑.c_button:disable()
    self.按钮_逃跑.c_handle_click.允许点击事件 = false
    self.按钮_切换.visible = true
    self.按钮_攻击.c_button:disable()
    self.按钮_攻击.c_handle_click.允许点击事件 = false
    for i = 0, self.切换武功类型.childCount - 1 do
        local ui = self.切换武功类型.getChildAt(i);
        if 0 == i then
            ui.c_button.state = 'c'
            ui.mouseEnabled = false
        else
            ui.c_button.state = ''
            ui.mouseEnabled = true
        end
    end
    for i = 0, self.选择武功.childCount - 1 do
        local ui = self.选择武功.getChildAt(i);
        ui.img = 0x5601100d;
        ui.mouseEnabled = false;
    end
    if G.GetOS() == 1 then
        self.obj.scaleX = 1
        self.obj.scaleY = 1
        self.obj.x = -300
    else
        self.obj.scaleX = 1.25
        self.obj.scaleY = 1.25
        local offset = self.obj.width * (self.obj.scaleX - 1)
        offset = math.min(offset, 64, self.obj.parent.width - 600)
        self.obj.x = -300 - offset
    end
end
function t:关闭()
    -- self.气槽.width = 0;
    self.按钮_查看属性.visible = false
    self.按钮_逃跑.c_button:disable()
    self.按钮_逃跑.c_handle_click.允许点击事件 = false
    self.按钮_切换.visible = false
    self.按钮_攻击.c_button:disable()
    for i = 0, self.切换武功类型.childCount - 1 do
        local ui = self.切换武功类型.getChildAt(i);
        ui.mouseEnabled = false
    end
    for i = 0, self.选择武功.childCount - 1 do
        local ui = self.选择武功.getChildAt(i);
        -- ui.mouseEnabled = false;
        ui.c_handle_click.允许点击事件 = false
    end
end
-- function t:click(tar)
--     if tar.parent == self.切换武功类型 then
--         for i = 0, self.切换武功类型.childCount - 1 do
--             local ui = self.切换武功类型.getChildAt(i);
--             if ui == tar then
--                 ui.c_button.state = 'c'
--                 ui.mouseEnabled = false
--             else
--                 ui.c_button.state = ''
--                 ui.mouseEnabled = true
--             end
--         end
--     end
-- end
------------------
function t:显示武功属性(o_kungfu_武功)
    if not o_kungfu_武功 then return end
    local lv = o_kungfu_武功.等级
    local hurt = G.call('通用_计算武功伤害', o_kungfu_武功)
    local experience = 100
    if o_kungfu_武功.升级 then
        if o_kungfu_武功.升级[lv] then
            if o_kungfu_武功.升级[lv - 1] then
                experience = 100 * (o_kungfu_武功.经验 - o_kungfu_武功.升级[lv - 1].需经验) / (o_kungfu_武功.升级[lv].需经验 - o_kungfu_武功.升级[lv - 1].需经验)
            else
                experience = 100 * o_kungfu_武功.经验 / o_kungfu_武功.升级[lv].需经验
            end
        else
        end
    end
    local str = string.format('%s Lv%-2d(%2.1f%%)[br]耗内: %-4d  耗气: %d[br]威力: ', o_kungfu_武功.名称, lv, experience, (o_kungfu_武功.需内力 or 0) * lv, o_kungfu_武功.需集气)
    if hurt[1] == hurt[2] then
        str = str .. hurt[1]
    else
        str = str .. hurt[1] .. ' - ' .. hurt[2]
    end
    self.武功属性.text = str
    self.武功属性.visible = true
end
function t:rollOver(tar)
    if tar.parent == self.选择武功 then
        local c = tar.c_handle_click
        if c and c.事件参数二 > 0 then
            self:显示武功属性(G.QueryName(c.事件参数二))
        end
    end
end
function t:rollOut(tar)
    self.武功属性.visible = false
end
return t