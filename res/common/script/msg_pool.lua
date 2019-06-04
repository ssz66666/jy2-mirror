local t = {}
local s_listener = {} -- {event,...,}
t.listener = s_listener
t.event = {}

function t.new_listener(t,co, cond)
    t.co = co
    t.cond = cond
    table.insert(s_listener,t)
end

function t.start_listen(co, mono)
    if mono then
        for k = #s_listener,1,-1 do
            local ls = s_listener[k]
            if ls.co == co then
                --ls.wait = wait_all
                ls.mono = mono
            end
        end
    end
end

function t.remove_listener(co)
    local lst = s_listener
    local ret
    local k = 1
    while k <= #lst do
        local ls = lst[k]
        if ls.co == co then
            if ret == nil then
                ret = k - 1
            end
            table.remove(lst,k)
            k = k - 1
        end
        k = k + 1        
    end
    return ret
end

return t