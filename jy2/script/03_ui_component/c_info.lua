--[[3008

]]

local G = require "gf"
local t = G.com()
function t:init()
    self.信息 = self.obj.getChildByName("信息")
    self.fps = self.信息.getChildByName("FPS")
    self.obj.visible = false
end
function t:keyDown(tar, info)
    local key = string.byte(info)
    if key == 67 then
        self.obj.visible = not self.obj.visible
    end
end
function t:update()
    if self.obj.visible then
        local t1 = G.GetGameTime();
        if self.t0 then
            self.fps.text = string.format("FPS: %2.1f", 1000 / (t1 - self.t0))
        end
        self.t0 = t1;
    end
    if G.MouseState() == 0 then 
        self.state = 'down'
    else 
        self.state = 'up'
    end 
end
function t:mouseDown(tar)
	if self.ignore then return end
    self.state = 'down'
    self.x0 = self.obj.x
    self.y0 = self.obj.y
end 
function t:mouseUp(tar)
	self.state = 'up'
end 
function t:mouseMove(tar)
    if self.state == 'down' then 
        local dx, dy = G.MouseDownDelta()
        self.obj.x = self.x0 + dx;
        self.obj.y = self.y0 + dy;
    end
end
return t