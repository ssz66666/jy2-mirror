local class = require('mare/utils/oo').class
local packager = require('mare/utils/packager')
local serializer = require('mare/common/serializer')

local Modem = class({

    constructor = function(self, iostream)
        self.iostream = iostream;
        self.listeners = {}
        self.connected = false
        self.chunk = ''
    end,

    on = function(self, event, listener)
        self.listeners[event] = listener
    end,

    emit = function(self, event, ...)
        local listener = self.listeners[event]
        if listener then
            listener(...)
        end
    end,

    connect = function(self)
        self.connected = false
        self.chunk = ''
        self.iostream:close()
        if self.iostream:open() then
            self.connected = true
            self:emit('connect')
        end
    end,

    disconnect = function(self)
        local connected = self.connected
        self.connected = false
        self.chunk = ''
        self.iostream:close()
        if connected then
            self:emit('disconnect')
        end
    end,

    feed = function(self, data)
        if not data or data == '' then
            return
        end

        local buffer = self.chunk .. data
        local chunk, pkgs
        chunk, pkgs = packager.parse(buffer)
        self.chunk = chunk

        for _, pkg in ipairs(pkgs) do
            local cmd = serializer.decode(pkg)
            self:emit('command', cmd)
        end
    end,

    write = function(self, data)
        local ok = self.iostream:write(data)
        if not ok then
            self:disconnect()
            return false
        end
        return true
    end,

    read = function(self, timeout)
        local ok, data = self.iostream:read(timeout)
        if not ok then
            self:disconnect()
            return false
        end
        self:feed(data)
        return true
    end,

    send = function(self, op, args)
        local pkg = serializer.encode({op, args})
        local data = packager.dump(pkg)
        if self:write(data) then
            self:read()
        end
    end,

    recv = function(self, timeout)
        self:read(timeout)
    end,

})

return {
    Modem = Modem,
}
