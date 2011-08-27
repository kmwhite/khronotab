$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'khronotab/cron_variable'
require 'khronotab/cron_comment'
require 'khronotab/cron_job'
require 'khronotab/cron_tab'
