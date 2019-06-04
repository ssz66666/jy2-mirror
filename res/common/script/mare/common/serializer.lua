local msgpack = require('cmsgpack')

local encode = function(obj)
    return msgpack.pack(obj)
end

local decode = function(bytes)
    return msgpack.unpack(bytes)
end

return {
    encode = encode,
    decode = decode,
}
