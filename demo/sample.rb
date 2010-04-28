#!/usr/bin/env ruby

require('rubygems')
require('khronotab')

include(Khronotab)

c = CronTab.new

c.read_from_file('sample.ct')
puts  c.jobs.first.inspect
