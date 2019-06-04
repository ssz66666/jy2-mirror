--[[3002

]]

local G = require "gf"
local t = G.com()
t.prop = 
{
    {name = "允许点击事件", type = 'boolean', ctrl = 'boolean'},
    {name = "事件名", type = 'string', ctrl = 'string'},
    {name = "事件参数一", type = 'string', ctrl = 'string'},
    {name = "事件参数二", type = 'string', ctrl = 'string'},
}
function t:init()
end
-- function t:set_允许点击事件()
--     if true == self.允许点击事件 then
--         self.obj.mouseEnabled = true;
--     elseif false == self.允许点击事件 then
--         self.obj.mouseEnabled = false;
--     end
-- end
function t:click(tar)
    if self.允许点击事件 and tar == self.obj then
        if nil ~= self.事件名 then
            G.trig_event(self.事件名, self.事件参数一, self.事件参数二);
        end
    end
end
return t