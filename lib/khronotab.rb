$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
module Khronotab
  class CronTab

    require 'khronotab/cron_variable'
    require 'khronotab/cron_job'

    VERSION = '1.3.2'

    attr_accessor :jobs, :variables

    def initialize opt={}
      self.read_from_file(opt[:file]) if opt[:file] 
    end

    def self.read_from_file(*args)
      self.new.read_from_file(*args)
    end

    def read_from_file(filename)
      @variables ||= []
      @jobs ||= []
        File.open(filename, 'r').readlines.each do |line|
          if CronVariable.matches?(line)
            @variables << CronVariable.add_new(line) 
          elsif CronJob.matches?(line)
            @jobs << CronJob.add_new(line)
          else
            STDERR.puts("Warning: Line is not a valid variable or job!")
          end
        end
      self
    end

    def write_to_file(filename)
      #TODO: Have this validate a file or append to the file if there
      # is new data. Just overwriting the damn thing isn't very
      # safe or wise.. -kmwhite 2010.04.19
      crontab = File.open(filename,'w')
      @variables.each do |variable|
        crontab.puts definition.to_line
      end
      @jobs.each do |job|
        crontab.puts job.to_line
      end
      crontab.flush
      crontab.close
    end
  end
end
