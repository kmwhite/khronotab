module Khronotab
  class CronComment

    class InvalidComment < Exception; end

    attr_reader :comment

    def self.matches?(cron_entry)
      !!(%r{\s*#.*}.match(cron_entry) || %r{^\W+$}.match(cron_entry))
    end

    def self.parse_new(comment = nil)
      CronComment.new(comment)
    end

    def initialize(comment = nil)
      fail(InvalidComment) if comment.nil?
      @comment = comment
    end

    def to_s
      @comment
    end

    def to_line
      self.to_s
    end

  end
end
