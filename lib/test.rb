#!/usr/bin/env ruby

require 'khronotab'

c = Khronotab::CronTab.new
c.read_from_file('../demo/sample.ct')
puts c.jobs.first.inspect
