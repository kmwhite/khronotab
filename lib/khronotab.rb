$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'khronotab/variable'
require 'khronotab/job'
module Khronotab
  class CronTab

    VERSION = '1.0.0'
    attr_accessor :jobs, :variables, :job_instance_class
    def initialize opt={}
      self.job_instance_class = opt[:job_instance_class] if opt[:job_instance_class] 
      self.read_from_file(opt[:file]) if opt[:file] 
    end
    def self.read_from_file(*args)
      self.new.read_from_file(*args)
    end
    def import_line(line)

    end 
    def read_from_file(filename)
      @variables ||= []
      @jobs ||=[]
       File.open(filename, 'r').readlines.each do |line|
          if Variable.matches?(line)
            @variables << Variable.add_new(line) 
          elsif Job.matches?(line)
            @jobs << Job.add_new(line,self.job_instance_class) 
          else
            STDERR.puts "WTF IS THIS: #{line}"
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
