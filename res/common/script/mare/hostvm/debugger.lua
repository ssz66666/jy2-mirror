local rdebug = require('remotedebug')

local debugger = {}

function debugger.idling(...)
    return rdebug.probe('$debugger.idling', ...)
end

function debugger.start(...)
    return rdebug.probe('$debugger.start', ...)
end

function debugger.stop(...)
    return rdebug.probe('$debugger.stop', ...)
end

function debugger.restart(...)
    return rdebug.probe('$debugger.restart', ...)
end

function debugger.keepalive(...)
    return rdebug.probe('$debugger.keepalive', ...)
end

function debugger.setopt(...)
    return rdebug.probe('$debugger.setopt', ...)
end

function debugger.repl(...)
    return rdebug.probe('$debugger.repl', ...)
end

function debugger.pause(...)
    return rdebug.probe('$debugger.pause', ...)
end

function debugger.print_behavior(...)
    return rdebug.probe('$debugger.print_behavior', ...)
end

return debugger;
