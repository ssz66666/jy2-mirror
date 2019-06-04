-- @Author: zhoutianya
-- @Date:   2018-10-23 9:10:00
 
 
-- define module
local profiler = {}
 
profiler.m_reports = {}
profiler.m_reportsByTitle = {}
profiler.m_startTime = 0
profiler.m_stopTime = 0
profiler.m_filename = ''

-- get the function title
function profiler:onFuncTitle(funcinfo)
 
    -- check
    assert(funcinfo)
 
    -- the function name
    local name = funcinfo.name or 'anonymous'
 
    -- the function line
    local line = string.format("%d", funcinfo.linedefined or 0)
 
    -- the function source
    local source = funcinfo.short_src or 'C_FUNC'
 
    -- make title
    return {
        name = name,
        source = source,
        line = line,
    }
end
 
-- get the function report
function profiler:onFuncReport(funcinfo)
 
    -- get the function title
    local title = self:onFuncTitle(funcinfo)
    local title_str = string.format("%s,%s,%s", title.name, title.source, title.line)
 
    -- get the function report
    local report = self.m_reportsByTitle[title_str]
 
    if not report then
        -- init report
        report = 
        {
            title       = self:onFuncTitle(funcinfo)
        ,   callcount   = 0
        ,   totaltime   = 0
        }
        -- save it
        self.m_reportsByTitle[title_str] = report
        table.insert(self.m_reports, report)
    end
    -- ok
    return report
end
 
-- profiling call
function profiler:onProfilieCall(funcinfo)
 
    -- get the function report
    local report = self:onFuncReport(funcinfo)
 
    assert(report)
 
    -- save the call time
    report.calltime    = os.clock()
 
    -- update the call count
    report.callcount   = report.callcount + 1
end
 
 
 
-- profiling return
function profiler:onProfilieReturn(funcinfo)
 
    -- get the stoptime
    local stoptime = os.clock()
 
    -- get the function report
    local report = self:onFuncReport(funcinfo)
 
    assert(report)
 
    -- update the total time
    if report.calltime and report.calltime > 0 then
		report.totaltime = report.totaltime + (stoptime - report.calltime)
        report.calltime = 0
	end
end
 
-- the profiling handler
function profiler.onProfileHandler(hooktype)
    -- the function info
    local funcinfo = debug.getinfo(2, 'nS')
 
    -- dispatch it
    if hooktype == "call" then
        profiler:onProfilieCall(funcinfo)
    elseif hooktype == "return" then
        profiler:onProfilieReturn(funcinfo)
    end
end
 
-- the tracing handler
function profiler.onTraceHandler(hooktype)
    -- the function info
    local funcinfo = debug.getinfo(2, 'nS')
    -- is call
    if hooktype == "call" then
 
        local name = funcinfo.name 
        local source = funcinfo.short_src or 'C_FUNC'
 
        if name and string.find(source, "%.lua") then--profiler.isfile(source) then
 
            -- the function line
            local line = string.format("%d", funcinfo.linedefined or 0)
            -- trace it
            print( string.fotmat("%s,%s,%s", name, source, line) )
        end
    end
end
 
PREFIX_TO_FILEPATH = {
    c_ = "03_ui_component",
    p_ = "04_program",
    a_ = "05_anim",
    n_ = "06_notify",
    t_ = "07_task",
}

function profiler:onFuncRealName(title)
    if title.name ~= "f" then
        return title.name
    end
    -- [string "p_battle"] 提取文件名
    local filename = string.sub(title.source, 10, -3)
    local lineidx = tonumber(title.line)
    filename = filename .. ".lua"
    print (filename)
    local file = io.open("../../project/dreamland/script/" .. PREFIX_TO_FILEPATH[ string.sub(filename, 1, 2) ] .. "/" .. filename, "r")
    file:seek("set")
    local lineindex = 0
    local ret = title.name
    for line in file:lines() do
        lineindex = lineindex + 1
        if lineindex == lineidx then
            local pattern = string.sub(line, 3, 3)
            local pattern_endidx = string.find(line, pattern, 4) - 1
            ret = string.sub(line, 4, pattern_endidx)
            break
        end
    end
    file:close()
    return ret
end

-- start profiling
function profiler:onStart(mode)
    if mode and mode == "trace" then
        debug.sethook(profiler.onTraceHandler, 'cr')
    else
        debug.sethook(profiler.onProfileHandler, 'cr')
    end
end
 

-- stop profiling
function profiler:onStop(mode)
    -- trace
    if mode and mode == "trace" then
        debug.sethook()
    else
        -- save the stop time
        self.m_stopTime = os.clock()
 
        -- stop to hook
        debug.sethook()
 
        -- calculate the total time 
        local totaltime = self.m_stopTime - self.m_startTime
 
        -- sort reports
        table.sort(self.m_reports, function(a, b)
            return a.totaltime > b.totaltime
        end)
 
        local file = io.open('profile.csv', 'w')
        local title = string.format('Percent,TotalTime,AverageTime,CallCount,Function,Source,Line\n')
        file:write(title)
        -- show reports
        for _, report in ipairs(self.m_reports) do
            -- calculate percent
            local percent = (report.totaltime / totaltime) * 100
            if report.callcount > 0 then
                local avgtime = report.totaltime * 1.0 / report.callcount
                if avgtime > 0.000 then
                    report.title.name = self:onFuncRealName(report.title)
                end
                local info = string.format("%6.2f,%0.3f,%0.3f,%d,%s,%s,%d\n", percent, report.totaltime, avgtime, report.callcount, report.title.name, report.title.source, report.title.line)
                file:write(info)
            end
        end
        file:close()
    end
end
 
-- return module
return profiler
