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

  def expanded_form
    values = Array.new
    @cron_form.split(',').each do |segment|
      case segment
        when /-/ #range
          range = segment.split('-').map! { |x| x.to_i }
          values.concat((range[0] .. range[1]).to_a)
        when /\// #interval
          counter = 0
          interval = segment.split('/').map! { |x|
            if x == '*'
              x = @maximum
            else
              x.to_i
            end
          }
          while counter < interval[0]
            values.push(counter)
            counter += interval[1]
          end
        when /[*]/
          values.concat((@minimum .. @maximum).to_a)
        else
          values << segment.to_i
      end
    end
    return values.sort.uniq
  end

  def to_s
    @cron_form
  end

end
