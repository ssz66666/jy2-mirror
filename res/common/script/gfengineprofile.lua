--[[
    @brief: profile Lua logic method.
    @author: stan
    @date: 2019-4.
    
    @modified: stan20190422, profile mthod by each logic frame.
]] 

local profiler = require 'profiler.c'

local GF = require "gfbase"

local PROFLIE_FOLDER = "profile/"
local PROFILE_FILE_NAME = "callgrind.lua"

local _profileFilePath = ""
local subFolder = ""

-- HOT_FUNC   
GF.PROFILE_MODE = 'HOT_FUNC'

if GF.PROFILE_MODE == nil then GF.PROFILE_MODE = "DEFAULT" end

-- sample count per frame in hot function mode profile
local HOT_FUNC_SAMPLE_COUNT = 1000
-- sample interval per frame in hot function mode profile
local HOT_FUNC_SAMPLE_INTERVAL = 10

-------------------------------------------------------------------------------------------------------
function _dumpToJsonValue(v)
    local t = type(v)
    local ret = v

    if t == "string" then
        -- replace \ to \\
        ret = "'" .. string.gsub(v, "\\", "\\\\") .. "'"
    elseif t == "number" and v ~= math.huge then
        -- nothing to do.
    elseif t == "boolean" then
        -- nothing to do.
    else
        ret = "'" .. tostring(v) .. "'"
    end

    return ret
end

-- dump to json format
function GF.dump(value, description, nesting)

    print("dumpToJson to begin...")

    if type(nesting) ~= "number" then nesting = 3 end

    local lookupTable = {}
    local result = {}

    -- local traceback = string.split(debug.traceback("", 2), "\n")
    -- print(traceback)
    -- print("\n\ndump from: " .. string.trim(traceback[3]) .. " to json")

    local function dump_(value, description, indent, nest, keylen)
        description = description or "<var>"
        local spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ",
                             keylen - string.len(_dumpToJsonValue(description)))
        end
        if type(value) ~= "table" then
            result[#result + 1] = string.format("%s%s%s : %s,", indent,
                                                _dumpToJsonValue(description),
                                                spc, _dumpToJsonValue(value))
        elseif lookupTable[tostring(value)] then
            result[#result + 1] = string.format("%s%s%s : '*REF*',", indent,
                                                _dumpToJsonValue(description),
                                                spc)
        else
            lookupTable[tostring(value)] = true
            if nest > nesting then
                result[#result + 1] = string.format("%s%s : '*MAX NESTING*',",
                                                    indent,
                                                    _dumpToJsonValue(description))
            else
                result[#result + 1] = string.format("%s%s : {", indent,
                                                    _dumpToJsonValue(description))
                local indent2 = indent .. " "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in pairs(value) do
                    keys[#keys + 1] = k
                    local vk = _dumpToJsonValue(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then keylen = vkl end
                    values[k] = v
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for i, k in ipairs(keys) do
                    dump_(values[k], k, indent2, nest + 1, keylen)
                end
                result[#result + 1] = string.format("%s},", indent)
            end
        end
    end
    dump_(value, description, "", 1)

    print("{")
    for i, line in ipairs(result) do print(line) end
    print("}\n\n")
end

-------------------------------------------------------------------------------------------

function file_exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end

    return file ~= nil
end

function file_isExistOrCreate(path)
    if file_exists(path) == false then
        require "lfs"
        lfs.mkdir(path)
    end
end

file_isExistOrCreate(PROFLIE_FOLDER)

---------------------------------------------------------------------
-- members
callstack = {}
instr_count = 0
last_line_instr_count = 0
local _tracefile = nil

mainfunc = "NULL"

functions = {}
methods = {}
method_id = 1
call_indent = 0

local function clearProfileData()
    callstack = {}
    instr_count = 0
    last_line_instr_count = 0
    _tracefile = nil

    mainfunc = "NULL"

    functions = {}
    methods = {}
    method_id = 1
    call_indent = 0

end

local function getfuncname(f) return ("%s"):format(tostring(f.func)) end

function trace(class)
    -- print("calling tracer: "..class)
    if class == "count" then
        instr_count = instr_count + 1
    elseif class == "line" then
        -- check if we know this function already
        local f = debug.getinfo(2, "lSf")
        if not functions[f.func] then
            functions[f.func] = {meta = f, lines = {}}
        end
        local lines = functions[f.func].lines
        lines[#lines + 1] = ("%d %d"):format(f.currentline,
                                             instr_count - last_line_instr_count)
        functions[f.func].last_line = f.currentline

        if mainfunc == "NULL" then mainfunc = f.func end

        last_line_instr_count = instr_count
    elseif class == "call" then
        -- add the function info to the stack
        --
        local f = debug.getinfo(2, "lSfn")

        callstack[#callstack + 1] = {
            short_src = f.short_src,
            func = f.func,
            linedefined = f.linedefined,
            name = f.name,
            instr_count = instr_count
        }

        if not functions[f.func] then
            functions[f.func] = {meta = f, lines = {}}
        end

        if not functions[f.func].meta.name then
            functions[f.func].meta.name = f.name
        end

        -- is this method already known ?
        if f.name then methods[tostring(f.func)] = {name = f.name} end

        -- print((" "):rep(call_indent)..">>"..tostring(f.func).." (".. tostring(f.name)..")")
        call_indent = call_indent + 1
    elseif class == "return" then
        if #callstack > 0 then
            -- pop the function from the stack and
            -- add the instr-count to the its caller
            local ret = table.remove(callstack)

            local f = debug.getinfo(2, "lSfn")
            -- if lua wants to return from a pcall() after a assert(),
            -- error() or runtime-error we have to cleanup our stack
            if ret.func ~= f.func then
                -- print("handling error()")
                -- the error() is already removed
                -- removed every thing up to pcall()

                while #callstack ~= 0 and callstack[#callstack].func ~= f.func do
                    table.remove(callstack)

                    call_indent = call_indent - 1
                end
                -- remove the pcall() too
                ret = table.remove(callstack)
                call_indent = call_indent - 1
            end

            local prev

            if #callstack > 0 then
                prev = callstack[#callstack].func
            else
                prev = mainfunc
            end

            local lines = functions[prev].lines
            local last_line = functions[prev].last_line

            call_indent = call_indent - 1

            -- in case the assert below fails, enable this print and the one in the "call" handling
            -- print((" "):rep(call_indent).."<<"..tostring(ret.func).." "..tostring(f.func).. " =? " .. tostring(f.func == ret.func))

            if (ret ~= nil) then
                assert(ret.func == f.func)

                lines[#lines + 1] = ("cfl=%s"):format(ret.short_src)
                lines[#lines + 1] = ("cfn=%s"):format(tostring(ret.func))
                lines[#lines + 1] = ("calls=1 %d"):format(ret.linedefined)
                lines[#lines + 1] = ("%d %d"):format(
                                        last_line and last_line or -1,
                                        instr_count - ret.instr_count)
            end

        end
        -- _tracefile:write("# --callstack: " .. #callstack .. "\n")
    else
        -- print("class = " .. class)
    end
end

local function func2name(m, tbl, prefix)
    prefix = prefix and prefix .. "." or ""

    -- print(prefix)

    for name, func in pairs(tbl) do
        if func == _G then
            -- ignore
        elseif m[tostring(func)] and type(m[tostring(func)]) == "table" and
            m[tostring(func)].id then
            -- already mapped
        elseif type(func) == "function" then
            -- remove the package.loaded. prefix from the loaded methods
            m[tostring(func)] = {
                name = (prefix .. name):gsub("^package\\.loaded\\.", ""),
                id = method_id
            }
            method_id = method_id + 1
        elseif type(func) == "table" and type(name) == "string" then
            -- a package, class, ...
            --
            -- make sure we don't look endlessly
            if m[tostring(func)] ~= "*stop*" then
                m[tostring(func)] = "*stop*"
                func2name(m, func, prefix .. name)
            end
        end
    end
end

--------------------------------------------------------------------------------------
-- write compressed binary profile file, for performance

local S_STRING_END = string.char(0x00)
local S_EMPTY_LINE = string.char(0x00) -- empty line

local E_FL = string.char(0x01) -- string
local E_FN = string.char(0x02) -- string
local E_CFL = string.char(0x03) -- string
local E_CFN = string.char(0x04) -- string
local E_CALLS = string.char(0x05) -- short
local E_SHORT15_2 = string.char(0x06) -- [short, byte] or [short 1] 如果第二个数为1，则省略，占用2byte, 否则占用 3byte

-- 15 bit short
local S15_MINUS_ONE = 0x7FFF -- 32767

-- 0x7FFE
local S15_NUMBER_END_1 = string.char(0x7F) -- E_SHORT15_2 (numer) end.
local S15_NUMBER_END_2 = string.char(0xFE) -- E_SHORT15_2 (numer) end.

local S15_FLAG_DEFAULT = 0X8000 -- S15 标记位, 第一个字节的前1位，为1. 表示第二个数为 1。 则每组占用2字节， 否则每组占用3字节。
local S15_MAX_VALUE = 0x7FFC -- 32764 S15 max value

local _profileDurationFile = nil
local _profile
local _frameStartClock = 0

-- big endian
local function writeShort(f, v)
    f:write(string.char((v & 0xFF00) >> 8), string.char(v & 0xFF))
end

local function writeByte(f, v) f:write(string.char(v & 0xFF)) end

function GF.beginProfileBinary(index)
    _profileFilePath = subFolder .. PROFILE_FILE_NAME .. tostring(index)

    -- record duration profile
    _profileDurationFile:write(tostring(index) .. ",")

    if (GF.PROFILE_MODE == "HOT_FUNC") then
        profiler.start(HOT_FUNC_SAMPLE_COUNT, HOT_FUNC_SAMPLE_INTERVAL)
    elseif (GF.PROFILE_MODE == "DURATION_FUNC") then
        profiler.start(_profileFilePath .. ".csv")
    else 
        _tracefile = io.open(_profileFilePath .. ".bin", "wb")
        debug.sethook(trace, "crl", 1)
    end

    _frameStartClock = os.clock()
end

function GF.endProfileBinary()
    _profileDurationFile:write(tostring(os.clock() - _frameStartClock) .. "\n")
    if GF._isProfiling == false then _profileDurationFile:close() end

    -- add hot func profile
    if (GF.PROFILE_MODE == "HOT_FUNC") then
        local info, n = profiler.info()

        profiler.stop()

        local profileHotFile = io.open(_profileFilePath .. ".csv", "w")

        profileHotFile:write("filename, line, call count\n")

        for filename, line_t in pairs(info) do
            for line, count in pairs(line_t) do
                profileHotFile:write(("%s, %d, %d\n"):format(filename, line, count))
            end
        end
        profileHotFile:write(("total=%d"):format(n))
        profileHotFile:close()

    elseif (GF.PROFILE_MODE == "DURATION_FUNC") then
        profiler.stop()
    else
        debug.sethook()

        -- try to build a reverse mapping of all functions pointers
        -- string.sub() should not just be sub(), but the full name
        --
        -- scan all tables in _G for functions

        -- resolve the function pointers
        func2name(methods, _G)

        for key, func in pairs(functions) do
            local f = func.meta

            if (not f.name) and f.linedefined == 0 then
                f.name = "(test-wrapper)"
            end

            local func_name = getfuncname(f)
            if methods[tostring(f.func)] then
                func_name = methods[tostring(f.func)].name
            end

            -- _tracefile:write("fl="..f.short_src.."\n")
            -- _tracefile:write("fn="..func_name.."\n")

            _tracefile:write(E_FL)
            _tracefile:write(f.short_src)
            _tracefile:write(S_STRING_END)

            _tracefile:write(E_FN)
            _tracefile:write(func_name)
            _tracefile:write(S_STRING_END)

            -- 用来标记 是否增加 双数字队列
            local lastTag = 0xFF

            for i, line in ipairs(func.lines) do
                local tag = line:sub(1, 4)

                if tag == "cfl=" then
                    if lastTag == E_SHORT15_2 then
                        -- 双数字队列结束
                        _tracefile:write(S15_NUMBER_END_1)
                        _tracefile:write(S15_NUMBER_END_2)
                    end

                    _tracefile:write(E_CFL)
                    _tracefile:write(line:sub(5))
                    _tracefile:write(S_STRING_END)
                    lastTag = E_CFL

                elseif tag == "cfn=" then
                    local m = methods[line:sub(5)]
                    if m then
                        -- _tracefile:write("cfn="..(methods[line:sub(5)].name).."\n")
                        _tracefile:write(E_CFN)
                        _tracefile:write(m.name)
                        _tracefile:write(S_STRING_END)
                    else
                        _tracefile:write(E_CFN)
                        _tracefile:write(line:sub(5))
                        _tracefile:write(S_STRING_END)
                    end

                    lastTag = E_CFN

                elseif tag == "call" then
                    -- calls=1 121
                    local num = tonumber(line:sub(9))

                    _tracefile:write(E_CALLS)
                    writeShort(_tracefile, num)
                    lastTag = E_CALLS

                else
                    -- tuple

                    -- _tracefile:write(line.."\n")
                    if lastTag ~= E_SHORT15_2 then
                        -- 双数字队列 开始
                        _tracefile:write(E_SHORT15_2)
                    end

                    local iterFun = string.gmatch(line, "[-%d]+")
                    local num1 = tonumber(iterFun())
                    local num2 = tonumber(iterFun())

                    if num1 > S15_MAX_VALUE then
                        print(string.format(
                                "[Error] profile num(%d) more than max num(%d)",
                                num1, S15_MAX_VALUE))
                    end

                    if num1 == -1 then num1 = S15_MINUS_ONE end

                    if num2 == 1 then
                        -- compressed tuple number, take 2 bytes
                        num1 = num1 | S15_FLAG_DEFAULT

                        writeShort(_tracefile, num1)
                    else
                        -- take 3 bytes
                        writeShort(_tracefile, num1)
                        writeByte(_tracefile, num2)
                    end

                    lastTag = E_SHORT15_2
                end
            end

            if lastTag == E_SHORT15_2 then
                -- 双数字队列结束
                _tracefile:write(S15_NUMBER_END_1)
                _tracefile:write(S15_NUMBER_END_2)
            end

            -- _tracefile:write("\n")
            _tracefile:write(S_EMPTY_LINE)
        end

        _tracefile:close()

        clearProfileData()
    end
 
end

GF._isProfiling = false

function GF.api.beginProfile()
    local now = os.date("%Y-%m-%d_%H%M%S/")
    subFolder = PROFLIE_FOLDER .. now
    file_isExistOrCreate(subFolder)

    print("GF.api.beginProfile")

    -- save mode to config file.
    local modeFile = io.open(subFolder .. "config.txt", "w")
    modeFile:write(GF.PROFILE_MODE)
    modeFile:close()

    -- save duration profile
    local profileFilePath = subFolder .. "duration.csv"
    print("save duration data to file:", profileFilePath)

    if not GF._isProfiling then
        _profileDurationFile = io.open(profileFilePath, "w")
    end

    GF._isProfiling = true
end

function GF.api.endProfile()
    print("GF.api.endProfile")
    GF._isProfiling = false
end

