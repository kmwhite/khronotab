module Khronotab
  class CronUnit
    attr_accessor :cron_form, :minimum, :maximum 

    def initialize(cron, min, max)
      @cron_form = cron
      @minimum = min
      @maximum = max
    end

    def contains?(value)
      expanded_form.include?(value)
    end

    def expand_range(segment)
      Range.new(*segment.split('-')).map(&:to_i)
    end

    def expand_interval(segment)
      counter = 0
      times = []
      interval = segment.split('/').map! { |x|
        if x == '*'
          x = @maximum
        else
          x.to_i
        end
      }
      while counter < interval[0]
        times.push(counter)
        counter += interval[1]
      end
      times
    end

    def expanded_form
      @cron_form.split(',').flat_map { |segment|
        case segment
          when /-/ #range
            expand_range(segment)
          when /\// #interval
            expand_interval(segment)
          when /[*]/
            (@minimum .. @maximum).to_a
          else
            segment.to_i
        end }.sort.uniq
    end

    def to_s
      @cron_form
    end

  end
end
