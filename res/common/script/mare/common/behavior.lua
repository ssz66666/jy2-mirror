local class = require('mare/utils/oo').class
local Blackbox = require('mare/common/shunts/blackbox').Blackbox
local Breakpoint = require('mare/common/shunts/breakpoint').Breakpoint
local Pace = require('mare/common/shunts/pace').Pace
local Situation = require('mare/common/shunts/situation').Situation
local Trapper = require('mare/common/shunts/trapper').Trapper

local Behavior = class({

    constructor = function(self)
        self.skip_situation = nil
        self.skip_blackboxes = {}
        self.pause_breakpoints = {}
        self.pause_trapper = nil
        self.pause_pace = nil
        self.pausing_stacks = nil
        self.scope_queue = {}
        self.watch_queue = {}
        self.repl_queue = {}
    end,

    match_skip_situation = function(self, step)
        local situation = self.skip_situation
        if situation and situation:match(step) then
            return situation
        end
        return nil
    end,

    match_skip_blackbox = function(self, step)
        for _, blackbox in ipairs(self.skip_blackboxes) do
            if blackbox:match(step) then
                return blackbox
            end
        end
        return nil
    end,

    match_pause_breakpoint = function(self, step)
        for _, breakpoint in ipairs(self.pause_breakpoints) do
            if breakpoint:match(step) then
                return breakpoint
            end
        end
        return nil
    end,

    match_pause_trapper = function(self, step)
        local trapper = self.pause_trapper
        if trapper and trapper:match(step) then
            return trapper
        end
        return nil
    end,

    match_pause_pace = function(self, step)
        local pace = self.pause_pace
        if pace and pace:match(step) then
            return pace
        end
        return nil
    end,

    set_skip_situation = function(self, props)
        if props then
            self.skip_situation = Situation:new(props)
            return
        end
        self.skip_situation = nil
    end,

    set_skip_blackboxes = function(self, items)
        local blackboxes = {}
        for _, props in ipairs(items) do
            table.insert(blackboxes, Blackbox:new(props))
        end
        self.skip_blackboxes = blackboxes
    end,

    set_pause_breakpoints = function(self, items)
        local breakpoints = {}
        for _, props in ipairs(items) do
            table.insert(breakpoints, Breakpoint:new(props))
        end
        self.pause_breakpoints = breakpoints
    end,

    insert_pause_breakpoint = function(self, props, pos)
        table.insert(self.pause_breakpoints, pos, Breakpoint:new(props))
    end,

    set_pause_trapper = function(self, props)
        if props then
            self.pause_trapper = Trapper:new(props)
            return
        end
        self.pause_trapper = nil
    end,

    set_pause_pace = function(self, props)
        if props then
            self.pause_pace = Pace:new(props)
            return
        end
        self.pause_pace = nil
    end,

    execute_pause = function(self, stacks)
        self.pausing_stacks = stacks
        self.pause_pace = nil
    end,

    execute_resume = function(self)
        self.pausing_stacks = nil
    end,

    is_pausing = function(self)
        return self.pausing_stacks ~= nil
    end,

    query_scope = function(self, value)
        table.insert(self.scope_queue, value)
    end,

    query_watch = function(self, value)
        table.insert(self.watch_queue, value)
    end,

    query_repl = function(self, value)
        table.insert(self.repl_queue, value)
    end,

    trace_step = function(self, step)
        if self.pause_pace then
            self.pause_pace:trace(step)
        end
    end,

    to_string = function(self)
        local shunts = {}
        if self.skip_situation then
            table.insert(shunts, self.situation:to_string())
        end
        for _, blackbox in ipairs(self.skip_blackboxes) do
            table.insert(shunts, blackbox:to_string())
        end
        for _, breakpoint in ipairs(self.pause_breakpoints) do
            table.insert(shunts, breakpoint:to_string())
        end
        if self.pause_trapper then
            table.insert(shunts, self.pause_trapper:to_string())
        end
        if self.pause_pace then
            table.insert(shunts, self.pause_pace:to_string())
        end
        for i, v in ipairs(shunts) do
            shunts[i] = string.format('    %s', v)
        end

        if #shunts == 0 then
            return '<Behavior>\n</Behavior>'
        end

        local children = table.concat(shunts, '\n')
        return string.format('<Behavior>\n%s\n</Behavior>', children)
    end,

})

return {
    Behavior = Behavior,
}
