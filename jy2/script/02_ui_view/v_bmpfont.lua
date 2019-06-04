--[[2047

]]
local G = require 'gf'
local c_layout_h = require 'c_layout_h'
local c_perfectsize = require 'c_perfectsize'
local c_bmpfont = require 'c_bmpfont'
local tp,tc,com,tk
tc = G.Entity()
G.cacheUI(tc)
tc.name = 'v_bmpfont'
tc.left = -26.500
tc.right = 26.500
tc.bottom = -48.500
tc.top = 48.500
tp = tc
	tc = G.Quad()
	tp.addChild(tc)
	tc.name = '1'
	tc.pivotX = 0.000
	tc.pivotY = 1.000
	tc.right = 53.000
	tc.bottom = -85.500
	tc.top = -11.500
	tc.anchor = 0x64640000
	tc.img = 0x56150001
	tp = tc
	tp = tp.parent
	--end
tp.c_perfectsize = setmetatable({}, c_perfectsize)
com = tp.c_perfectsize
com['height'] =false
com['expheight'] =nil
com['minheight'] =nil
com['width'] =true
com['expwidth'] =0.000
com['minwidth'] =nil
tp.c_layout_h = setmetatable({}, c_layout_h)
com = tp.c_layout_h
com['alignment_h'] =1.000
com['alignment_v'] =1.000
com['RowSpace'] =0.000
com['StartX'] =0.000
com['changePivot'] =false
com['changeAnchor'] =false
tp.c_bmpfont = setmetatable({}, c_bmpfont)
com = tp.c_bmpfont
com['text'] ='1'
