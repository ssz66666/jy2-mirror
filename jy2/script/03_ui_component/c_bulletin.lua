--[[300d

]]
local G = require "gf"
local t = G.com()
local WebView = require "webview.c"

t.prop =
{
    {name = '网址', type = 'string', ctrl = 'string'},
}

function t:init()
    self.网页 = self.obj.getChildByName('网页')
end
function t:setData(url)
    self.webIndex = WebView.addWebView()
    self:displayHTML(url)
end
function t:displayHTML(url)
    if self.webIndex ~= nil and url ~= nil then
        WebView.displayHTML(self.webIndex, url)
        WebView.displayHTML(self.webIndex, url)
        WebView.displayHTML(self.webIndex, url)
        WebView.displayHTML(self.webIndex, url)
        self:updateWebViewPos()
        WebView.showWebView(self.webIndex, self.obj.visible)
    end
end
function t:updateWebViewPos()
    if self.webIndex == nil then
        return
    end
    local width = G.Stage().real_width()
    local height = G.Stage().real_height()
    if G.GetOS() == 1 then
        local asp = 1280 / 720
        if width / height < asp then
            height = width / asp
        else
            width = 480 * asp
        end
        local x = (width - self.网页.width) / 2 + self.网页.x
        x = x * 1280 / width
        local y = (height - self.网页.height) / 2 - self.网页.y
        y = y * 720 / height
        width = self.网页.width * 1280 / width
        height = self.网页.height * 720 / height
        WebView.setWebViewPos(self.webIndex, x, y, width, height, height)
    else
        local x = (width - self.网页.width) / 2 + self.网页.x
        local y = (height - self.网页.height) / 2 - self.网页.y
        width = self.网页.width
        height = self.网页.height
        WebView.setWebViewPos(self.webIndex, x, y, width, height, height)
    end
end
function t:update()
    self:updateWebViewPos()
end
function t:close()
    if self.webIndex ~= nil then
        WebView.removeWebView(self.webIndex)
    end 
end

return t