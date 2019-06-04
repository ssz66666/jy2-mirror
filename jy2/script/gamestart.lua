-- require 'strict'
require 'require_a_n'
local G = require "gf"
local t = G.api

-- 兼容某些睿智代码
SAVE_EVENT_LIST = {}
SAVE_EVENT_COUNT_LIST = {}
NEW_DATA_TEST_FZT = false

-- 主入口
t.init = function()
    G.call('初始化')
end
-- 游戏主入口,进入init函数
G.start_program('init')