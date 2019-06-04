-- rdebug = require('remotedebug')
-- console = require('mare/hostvm/console')
-- debugger = require('mare/hostvm/debugger')
-- rdebug.start('debug-test') -- {pause=true}

-- lua调试模块
-- local breakSocketHandle,debugXpCall = require("luaide/luadebug")("localhost",7003)
-- require("luaide/mobdebug").start()

local c = require "gcore.c"
local lfs = require "lfs.c"
local G = require "gf"
require 'servershare/gfdream'
local co = require "co"
local cfg = {}
SAVE_EVENT_COUNT_LIST = {}
SAVE_EVENT_COUNT = {}
SAVE_C_EVENT_LIST = {}
cfg.W = 600
cfg.H = 480
cfg.HALF_W = cfg.W  /2
cfg.HALF_H = cfg.H  /2
Config = cfg
c.SetResourceSize(cfg.W, cfg.H)
-- luadb.init(G.call,G.QueryName,co.error)
-- G.DBLoad('dbmain')
NEW_DATA_TEST_FZT = false
--load combo
local image_path = c.GetPath(0x06000000)

local recur_add,id

recur_add = function(pathID)
	local path = c.GetPath(pathID)
	for f in lfs.dir(path) do
		local dot = string.find(f,'%.')
		if dot == nil then --dir
			id = pathID | (c.ToHexUINT(f) << 16)
			recur_add(id)
		elseif dot == 1 then -- ignore
		else -- file
			id = c.ToHexUINT(f) | pathID | 0x50000000
			--print(f, id)
			c.addImage(id,id)
		end
	end
end

local w = c.imageSize(0x56100001)
c.addImage(0x56000001,0x56000001)
--if not w then recur_add(0x06000000) end

local g9 = require "o_image"
G.loadGrid9(g9)
local ft = require "o_font"
G.loadFont(ft)
local fs = require "o_fontstyle"
G.loadFontStyle(fs)

require 'servershare/require_o_p'
require 'require_a_n'
c.SetTextRecording(true)
G.SetDefaultAnim('prepare')
c.SetMainloop(G.main)