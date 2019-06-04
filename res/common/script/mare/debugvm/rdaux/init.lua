local lo = require('mare/utils/lodash')
local frame = require('mare/debugvm/rdaux/frame')
local step = require('mare/debugvm/rdaux/step')
local stack = require('mare/debugvm/rdaux/stack')
local locals = require('mare/debugvm/rdaux/locals')
local upvalues = require('mare/debugvm/rdaux/upvalues')
local inspect = require('mare/debugvm/rdaux/inspect')

local exports = lo.assign({}, frame, step, stack, locals, upvalues, inspect)
return exports
