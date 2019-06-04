local GF = require "gfbase"
local crypt = require "crypt.c"

local hex2Num = {
    ["0"] = 0,
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["a"] = 10,
    ["b"] = 11,
    ["c"] = 12,
    ["d"] = 13,
    ["e"] = 14,
    ["f"] = 15,
}

local hex = "0123456789"
local checkCode1Init = 4
local checkCode2Init = 7

function GF.getCheckCode(hexmac, initv)
    local code = initv                                                         
    for i=1, #hexmac do
        code = (code << 4 | hex2Num[ string.sub(hexmac, i, i) ]) % 10
    end
    local codebit = string.sub(hex, code+1, code+1)
    return codebit
end

-- 获取CDKEY
function GF.getCDKey(key)
    print ("steam id is", key)
    local rawsecret1, rawsecret2 = "71019238", "91828321"                 -- 1、随便写2个固定的8位字符串
    local secret = crypt.dhsecret(rawsecret1, rawsecret2)                 -- 2、生成密钥
    print("secret is", string.byte(secret, 1, 8) )
    local hashkey = crypt.hashkey(key)
    print("hashkey is", string.byte(hashkey, 1, 8) )
    local hmac = crypt.hmac64(hashkey, secret)                            -- 3、利用密钥对key进行加密
    print("hmac is", string.byte(hmac, 1, 8) )
    local hexmac = crypt.hexencode(hmac)                                  -- 4、转换成十六进制表示的hex
    print("hex of hmac is", hexmac )
    local checkcode1 = GF.getCheckCode(hexmac, checkCode1Init)            -- 5、生成1号校验位
    local checkcode2 = GF.getCheckCode(hexmac, checkCode2Init)            -- 6、生成2号校验位
    local cdkey = hexmac .. checkcode1 .. checkcode2
    print("final cd key is ", cdkey)
    return cdkey                                                          -- 7、hexmac 连接上两个校验位就是完整的 CDKEY 了
end

-- 判断CDKEY合法性
-- 提示： CDKEY 非法
function GF.isCDKeyValid(cdkey)
    if #cdkey < 3 then
        return false
    end
    local checkCode1 = string.sub(cdkey, -2, -2)
    local checkCode2 = string.sub(cdkey, -1, -1)
    local hexmac = string.sub(cdkey, 1, -3)
    if GF.getCheckCode(hexmac, checkCode1Init) ~= checkCode1 then
        return false
    end
    if GF.getCheckCode(hexmac, checkCode2Init) ~= checkCode2 then
        return false
    end
    return true
end

-- 判断CDKEY是否被使用
-- 提示： CDKEY 已被使用
function GF.isCDKeyUsed(key, cdkey)
    return GF.getCDKey(key) ~= cdkey
end
