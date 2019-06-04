local GF = require "gfbase"

local memCryptConfig

-- 注意：上线后参数定下来以后就不能再改了--
-- 否则解密的时候无法解密回原文
local CRYPT_ARGS = {
    P1 = -53147,
    P2 = 63719,
    P3 = 187874,      -- 101101110111100010
    P4 = 85,          -- 1010101
}

local function I(v)
    return math.floor(tonumber(v))
end

----------------------------------------------------------------------
------------------------ 一些简单的加密函数 O_o ------------------------
----------------------------------------------------------------------

-- 1、线性加密
local function Encode1(v)
    return v * CRYPT_ARGS.P1 + CRYPT_ARGS.P2
end

local function Decode1(v)
    v = v - CRYPT_ARGS.P2
    if v % CRYPT_ARGS.P1 ~= 0 then
        -- 作弊，直接清零
        return 0
    end
    return v // CRYPT_ARGS.P1
end

-- 2、先异或，再线性加密
local function Encode2(v)
    return (I(v) ~ CRYPT_ARGS.P3) * CRYPT_ARGS.P1 + CRYPT_ARGS.P2
end

local function Decode2(v)
    v = v - CRYPT_ARGS.P2
    if v % CRYPT_ARGS.P1 ~= 0 then
        -- 作弊，直接清零
        return 0
    end
    return (v // CRYPT_ARGS.P1) ~ CRYPT_ARGS.P3
end


-- 3、简单异或加密
local function SimpleEncode(v)
    return I(v * 10000) ~ CRYPT_ARGS.P4
end

local function SimpleDecode(v)
    return (v ~ CRYPT_ARGS.P4) / 10000
end

local encodeFuncs = {
    Encode1, Encode2, SimpleEncode
}
local decodeFuncs = {
    Decode1, Decode2, SimpleDecode
}
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------


local function getMemCryptConfig()
    if memCryptConfig == nil then
        if type(GF.get_mem_ctrpy_config) == 'function' then
            memCryptConfig = GF.get_mem_ctrpy_config()
        end
    end
    return memCryptConfig
end

local function isCrypt(tbl, key)
    if getMemCryptConfig() == nil then
        return false
    end
    local mcInfo = getMemCryptConfig()[key]
    -- 不属于加密字段
    if mcInfo == nil then
        return false
    end
    -- 属于加密字段，但是表不能对上
    if mcInfo.tablename ~= nil and mcInfo.tablename ~= tbl.name then
        return false
    end
    return true
end

local function getRawKey(key)
    return key .. "__RAW__"
end

local function getMemCryptKey(key)
    return key .. "__MEM_CR__"
end

local function isValueEqual(a, b)
    return math.abs(a - b) < 1e-6
end

-- 外部不调用这个接口
function GF.memCryptRawset(tbl, key, value)
    -- 1、获取 key 对应的内存加密配置信息
    local mcInfo = getMemCryptConfig()[key]
    -- 2、计算这个值的内存加密值 evalue
    local evalue = GF.memEncode(mcInfo.crypttype, value)
    -- print ('memory encode ', key, value, evalue)
    -- 3、设置原值(让修改器搜到，但是改了没用，而且会被发现作弊了)
    rawset(tbl, getRawKey(key), value)
    -- 4、设置加密值(修改器搜不到的值)
    rawset(tbl, getMemCryptKey(key), evalue)
end


function GF.rawsetMemEncodeValue(tbl, key, value)
    if isCrypt(tbl, key) then
        if value ~= nil then
            GF.memCryptRawset(tbl, key, value)
        end
    else
        rawset(tbl,'_dynamic_' .. key, value)
    end
end


-- rawval 代表从静态O表中读取的属性，作为初始参考值
function GF.rawgetMemDecodeValue(tbl, key, rawval)
    -- 1、根据key判断这个数值是否需要做内存加密
    if isCrypt(tbl, key) then
        -- 2、mcInfo 存储内存加密的配置信息
        local mcInfo = getMemCryptConfig()[key]
        -- 3、查找是否存在内存加密值
        local evalue = rawget(tbl, getMemCryptKey(key))
        if evalue == nil then
            local initval = rawval or mcInfo.initval
            -- 4、如果不存在，说明尚未初始化，进行初始化操作
            GF.memCryptRawset(tbl, key, initval)
            evalue = rawget(tbl, getMemCryptKey(key))
        end
        -- 5、得到解密值
        local dvalue = GF.memDecode(mcInfo.crypttype, evalue)
        local value = rawget(tbl, getRawKey(key))
        -- print ('memory decode <', key, evalue, dvalue, '>')
        if not isValueEqual(value, dvalue) then
            -- 作弊了！！！该怎么处理？！！！
            print (key, ' cheat by 3rd party software! (' ..'real value is <' .. dvalue .. '>, cheat by <' .. value .. '>)')
            GF.memCryptRawset(tbl, key, dvalue)
        end
        return dvalue
    end
    -- 6、走这个接口的一定是经过内存加密的，否则返回 rawval
    return rawval
end


-- 没有设置meta table的直接调用这个接口进行 加密
function GF.memEncode(crypttype, value)
    return encodeFuncs[crypttype](value)
end

-- 没有设置meta table的直接调用这个接口进行 解密
function GF.memDecode(crypttype, value)
    return decodeFuncs[crypttype](value)
end