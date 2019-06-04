-- Author: Chen Bochao
-- Date: 2018/July/27
-- Manage git command queue and git work coroutine, provide git interface.

local GF = require "gfbase"
local git = require 'git.c'

-- 命令队列, 存放 git 命令信息
-- git 命令信息数据结构:
-- path: 版本库路径
-- cb: 回调函数
-- cmd: 命令
-- param_1: 命令参数 1
-- param_2: 命令参数 2
-- repo: git 库名称(项目名称)
-- branch: 分支名称
local cmd_queue = {}

-- 命令执行的协程
local cmd_coro = nil

-- 本次 git 命令的回调函数
local git_cb = nil

-- git 的循环更新逻辑
table.insert(GF.update, function()
    if type(git_cb) == "function" then
        if type(git) == 'boolean' then
            package.loaded['git.c'] = nil
            git = require 'git.c'
        end
		git.update(git_cb)
	end
end)

-- 往命令队列中添加新的命令, 如果没有正在执行的命令协程, 则启动协程
-- @params  path:版本库路径
-- @params  cb:回调函数
-- @params  cmd:命令
-- @params  param_1:命令参数 1
-- @params  param_2:命令参数 2
-- @params  repo:操作的版本库名称
-- @params  branch:操作的分支名称
function GF.add_cmd(path, cb, cmd, param_1, param_2, repo, branch)
    local cmd_table = {}
    -- 如果该命令已经在队列中了, 就不再重复添加了
    if GF.is_in_queue(path, cb, cmd, param_1, param_2, repo, branch) then
        return
    end
    cmd_table.path = path
    cmd_table.cb = cb
    cmd_table.cmd = cmd
    cmd_table.param_1 = param_1
    cmd_table.param_2 = param_2
    cmd_table.repo = repo
    cmd_table.branch = branch
    cmd_queue[#cmd_queue + 1] = cmd_table

    if cmd_coro == nil then
        print("--== init co")
        -- 如果没有可用的协程, 则需要初始化新的协程
        cmd_coro = coroutine.create(GF.proc_cmd)
    elseif coroutine.status(cmd_coro) == "dead" then
        print("--== restart co")
        -- 如果没有可用的协程, 则需要初始化新的协程
        cmd_coro = coroutine.create(GF.proc_cmd)
    elseif coroutine.status(cmd_coro) == "running" or #cmd_queue > 1 then
        print("--== cmd idle")
        return
    end
    coroutine.resume(cmd_coro)
end

-- 处理命令队列中的命令
function GF.proc_cmd()
    local path
    local cb
    local cmd
    local param_1
    local param_2
    while true do
        if #cmd_queue > 0 then
            path = cmd_queue[1].path
            cb = cmd_queue[1].cb
            cmd = cmd_queue[1].cmd
            param_1 = cmd_queue[1].param_1
            param_2 = cmd_queue[1].param_2
            print("--== execute cmd " .. tostring(cmd), " total cmd count " .. tostring(#cmd_queue))
            git_cb = cb
            if param_1 == nil then
                git.cmd(path, cmd)
            elseif param_2 == nil then
                git.cmd(path, cmd, param_1)
            else
                git.cmd(path, cmd, param_1, param_2)
            end

        end
        print("--== co idle")
        coroutine.yield()
    end
end

-- 命令执行完毕, 删除队列的第一个命令
function GF.cmd_end()
    print("--== cmd end")
    table.remove(cmd_queue, 1)
    if #cmd_queue > 0 then
        print("--== next cmd")
        coroutine.resume(cmd_coro)
    else
        print("--== cmd queue clear")
    end
end

-- 判断一个命令是否已经在命令队列中了
-- @params  path:版本库路径
-- @params  cb:回调函数
-- @params  cmd:命令
-- @params  param_1:命令参数 1
-- @params  param_2:命令参数 2
-- @params  repo:操作的版本库名称
-- @params  branch:操作的分支名称
-- @return  返回一个命令是否已经在队列中
function GF.is_in_queue(path, cb, cmd, param_1, param_2, repo, branch)
    for i = 1, #cmd_queue do
        if cmd_queue[i].path == path and cmd_queue[i].cb == cb and cmd_queue[i].cmd == cmd and
        cmd_queue[i].param_1 == param_1 and cmd_queue[i].param_2 == param_2 and
        cmd_queue[i].repo == repo and cmd_queue[i].branch == branch then
            return true
        end
    end
    return false
end

-- 获取当前正在执行的命令
-- @return  返回当前正在执行的命令的 table
function GF.get_executing_cmd()
    return cmd_queue[1]
end

-- 获取当前的 git 状态
-- @return  返回 git 的状态
function GF.get_git_state()
    return git.state()
end