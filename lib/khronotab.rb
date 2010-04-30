$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Khronotab
  class CronTab
    require 'khronotab/joblist'
    require 'khronotab/variablelist'

    VERSION = '0.7.5'
    attr_accessor :jobs, :variables

    def read_from_file(filename)
      @variables ||= ::VariableList.new
      @jobs ||= ::JobList.new
      File.open(filename, 'r').readlines.each do |line|
        case line
          when %r{^\s*[^#]\w+=.+}i
            @variables.add_new(line)
          when %r{^\s*[^#]((\d{1,2}|[*]|[-\/,])+|\s+){5}\S+\s+.+}i
            @jobs.add_new(line) 
            next
          else
            #STDERR.puts("Line is neither a Job or a Definition.\n\t#{line}")
            next
        end
      end
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
