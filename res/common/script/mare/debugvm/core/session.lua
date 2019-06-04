local class = require('mare/utils/oo').class
local libstr = require('mare/utils/string')
local Behavior = require('mare/common/behavior').Behavior
local Frontend = require('mare/common/frontend').Frontend
local Modem = require('mare/common/modem').Modem

local STATE_INIT = 0
local STATE_CONNECTING = 1
local STATE_HANDSHAKING = 2
local STATE_PREPARING = 3
local STATE_READY = 4

local Session = class({

    constructor = function(self, config, iostream)
        self.config = config

        self.modem = Modem:new(iostream)
        self.behavior = Behavior:new()
        self.frontend = Frontend:new()

        self.modem:on('connect', self:on_modem_connect())
        self.modem:on('disconnect', self:on_modem_disconnect())
        self.modem:on('command', self:on_modem_command())
        self.frontend:on('message', self:on_frontend_message())

        self.state = STATE_INIT
        self.storage = {}
    end,

    is_ready = function(self)
        return self.state == STATE_READY
    end,

    start = function(self)
        if self.state == STATE_INIT then
            self.state = STATE_CONNECTING
            self.modem:connect()
        end
    end,

    stop = function(self)
        if self.state ~= STATE_INIT then
            self.state = STATE_INIT
            self.modem:disconnect()
        end
    end,

    restart = function(self)
        self.modem:disconnect()
        self.modem:connect()
    end,

    on_modem_connect = function(self)
        return function()
            self.state = STATE_HANDSHAKING
            local query = libstr.urlencode(self.config.args)
            local url = string.format('/session/%s?%s', self.config.id, query)
            self.modem:send('handshake', url)
            while self.state == STATE_HANDSHAKING do
                self.modem:recv(0.1)
            end
        end
    end,

    on_modem_disconnect = function(self)
        return function()
            self.state = STATE_INIT
        end
    end,

    on_modem_command = function(self)
        return function(command)
            local op = command[1]
            local args = command[2]
            if op == 'handshaked' then
                self:apply_handshaked(args)
                return
            end
            if op == 'message' then
                self:apply_message(args)
                return
            end
        end
    end,

    on_frontend_message = function(self)
        return function(message)
            self:message(message)
        end
    end,

    apply_handshaked = function(self)
        self.state = STATE_PREPARING
        self:message({method='sessionPrepare'})
        while self.state == STATE_PREPARING do
            self.modem:recv(0.1)
        end
    end,

    apply_message = function(self, message)
        local method = message.method
        local params = message.params

        if method == 'session.prepareInfo' then
            self.behavior:set_skip_blackboxes(params.blackboxes)
            self.behavior:set_pause_breakpoints(params.breakpoints)
            self.state = STATE_READY
            return
        end

        if method == 'behavior.setSkipSituation' then
            self.behavior:set_skip_situation(params)
            return
        end
        if method == 'behavior.setSkipBlackBoxes' then
            self.behavior:set_skip_blackboxes(params)
            return
        end
        if method == 'behavior.setPauseBreakpoints' then
            self.behavior:set_pause_breakpoints(params)
            return
        end
        if method == 'behavior.setPauseTrapper' then
            self.behavior:set_pause_trapper(params)
            return
        end
        if method == 'behavior.setPausePace' then
            self.behavior:set_pause_pace(params)
            return
        end
        if method == 'behavior.executeResume' then
            self.behavior:execute_resume(params)
            return
        end
        if method == 'behavior.queryScope' then
            self.behavior:query_scope(params)
            return
        end
        if method == 'behavior.queryWatch' then
            self.behavior:query_watch(params)
            return
        end
        if method == 'behavior.queryRepl' then
            self.behavior:query_repl(params)
            return
        end
    end,

    heartbeat = function(self)
        self.modem:send('heartbeat')
    end,

    message = function(self, message)
        self.modem:send('message', message)
    end,

    sync = function(self, timeout)
        self.modem:recv(timeout)
    end,

})

return {
    Session = Session,
}
