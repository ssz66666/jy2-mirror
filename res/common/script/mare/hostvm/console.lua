local rdebug = require('remotedebug')

local console = {}

function console.log(...)
    rdebug.probe('$console.log', ...)
end

function console.debug(...)
    rdebug.probe('$console.debug', ...)
end

function console.info(...)
    rdebug.probe('$console.info', ...)
end

function console.warn(...)
    rdebug.probe('$console.warning', ...)
end

function console.error(...)
    rdebug.probe('$console.error', ...)
end

function console.trace(...)
    rdebug.probe('$console.trace', ...)
end

function console.assert(...)
    rdebug.probe('$console.assert', ...)
end

function console.group(...)
    rdebug.probe('$console.startGroup', ...)
end

function console.group_collapsed(...)
    rdebug.probe('$console.startGroupCollapsed', ...)
end

function console.group_end(...)
    rdebug.probe('$console.endGroup', ...)
end

function console.clear(...)
    rdebug.probe('$console.clear', ...)
end

return console;
