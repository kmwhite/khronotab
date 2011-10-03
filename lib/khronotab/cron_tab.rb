module Khronotab
  class CronTab

    class InvalidLineType < Exception; end

    attr_accessor :lines

    def initialize(opt={})
      @lines ||= []
      self.read_from_file(opt[:file]) if opt[:file] 
    end

    def self.read_from_file(*args)
      self.new.read_from_file(*args)
    end

    def read_from_file(filename)
      File.open(filename,'r').readlines.each_with_index do |line,index|
        @lines << { :index => index, :content => determine_line_type(line).parse_new(line) }
      end
      self
    end 

    def write_to_file(filename)
      File.open(filename,'w') do |crontab|
        @lines.sort_by {|l| l[:index] }.each do |line|
          crontab.puts(line[:content].to_line)
        end
      end
    end

    def jobs
      @lines.select { |line| line[:content].is_a?(CronJob) }
    end

    def comments
      @lines.select { |line| line[:content].is_a?(CronComment) }
    end

    def variables
      @lines.select { |line| line[:content].is_a?(CronVariable) }
    end

    def determine_line_type(line)
      return CronJob if CronJob.matches?(line)
      return CronVariable if CronVariable.matches?(line)
      return CronComment if CronComment.matches?(line)
      fail(InvalidLineType)
    end

  end
end
