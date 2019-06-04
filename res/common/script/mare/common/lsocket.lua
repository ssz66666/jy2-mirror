local lsocket = require('lsocket')

local IOStream = {

    new = function(cls, ...)
        local self = {}
        setmetatable(self, cls)
        cls.__index = cls
        cls.constructor(self, ...)
        return self
    end,

    constructor = function(self, props)
        self.host = props.host
        self.port = props.port
        self.socket = nil
    end,

    open = function(self)
        local socket, err = lsocket.connect(self.host, self.port)
        if not socket then
            return false, err
        end

        lsocket.select(nil, {socket}, 1)
        local ok, err1 = socket:status()
        if not ok then
            return false, err1
        end

        self.socket = socket
        return true, nil
    end,

    close = function(self)
        if self.socket then
            self.socket:close()
            self.socket = nil
        end
    end,

    write = function(self, data)
        if not self.socket then
            return false, 'not connected'
        end

        local socket = self.socket
        local selects = {socket}

        local error = nil
        local sent = 1
        local length = #data
        while sent <= length do
            lsocket.select(nil, selects, 0)
            local chunk = data:sub(sent)
            local nbytes, err = socket:send(chunk)
            if err then
                error = err
                break
            end

            if nbytes == false then
                lsocket.select(nil, selects, 0.1)
            else
                sent = sent + nbytes
            end

        end

        if error then
            return false, error
        end

        return true, nil
    end,

    read = function(self, timeout)
        if not self.socket then
            return false, 'not connected'
        end

        timeout = timeout or 0
        local socket = self.socket
        local selects = {socket}

        local error = nil
        local chunks = {}
        while true do
            lsocket.select(selects, timeout)
            local chunk, err = socket:recv()
            if chunk == nil then
                error = err or 'remote closed'
                break
            end

            if chunk == false then
                break
            end

            table.insert(chunks, chunk)
        end

        if error then
            return false, error
        end

        local data = table.concat(chunks)
        return true, data
    end,

    is_opened = function(self)
        return self.socket ~= nil
    end,

    is_closed = function(self)
        return self.socket == nil
    end,

}

return {
    IOStream = IOStream,
}
