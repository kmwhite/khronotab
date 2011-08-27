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
      @lines = File.open(filename,'r').readlines.map.with_index do |line,index|
        { :index => index, :content => parse_line(line) }
      end
      self
    end 

    # TODO: Have this validate a file or append to the file if there
    # is new data. Just overwriting the damn thing isn't very
    # safe or wise.. -kmwhite 2010.04.19
    def write_to_file(filename)
      File.open(filename,'w') do |crontab|
        @lines.sort_by {|line| line[:index] }.each do |line|
          crontab.puts(line[:data].to_line)
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

    def parse_line(line)
      line_type = determine_line_type(line)
      line_type.parse_new(line)
    end

    def determine_line_type(line)
      return CronJob if CronJob.matches?(line)
      return CronVariable if CronVariable.matches?(line)
      return CronComment if CronComment.matches?(line)
      fail(InvalidLineType)
    end

  end
end
