require 'irb/completion'
require 'map_by_method'
require 'pp'
require 'rubygems'
require 'wirble'
require 'what_methods'

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 100

Wirble.init
Wirble.colorize
