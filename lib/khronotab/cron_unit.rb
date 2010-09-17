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
    range = segment.split('-').map! { |x| x.to_i }
    (range[0] .. range[1]).to_a
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
    values = []
    @cron_form.split(',').each do |segment|
      case segment
        when /-/ #range
          values.concat(expand_range(segment))
        when /\// #interval
          values.concat(expand_inteval(segment))
        when /[*]/
          values.concat((@minimum .. @maximum).to_a)
        else
          values << segment.to_i
      end
    end
    values.sort.uniq
  end

  def to_s
    @cron_form
  end

end
