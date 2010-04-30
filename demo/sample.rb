#!/usr/bin/env ruby

require 'khronotab'
c = Khronotab::CronTab.new
c.read_from_file('sample.ct')
puts c.jobs.first.inspect
puts c.jobs.first.runs_today?
