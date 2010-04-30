require 'time'

class Job < Hash
  require 'khronotab/crontypes'

  def initialize(data)
    self[:minutes] = data[:minutes]
    self[:hours] = data[:hours]
    self[:days_of_month] = data[:days_of_month]
    self[:month] = data[:month]
    self[:days_of_week] = data[:days_of_week]
    self[:user] = data[:user]
    self[:command] = data[:command]
  end

  def expand_field(cron_data, data_type)
    #---------------------------------------------------------
    # The data_type.new will have the max and min for that type
    #--------------------------------------------------------
    #return an array composed of all the valid fields values
    #so that self[:field_name].include[value] will return true
    #as a check to if the value runs today
    values = Array.new
    cron_data.split(',').each do |segment|
      case segment
        when /-/ #range
          range = segment.split('-').map! { |x| x.to_i }
          values.concat((range[0] .. range[1]).to_a)
        when /\// #interval
          counter = 0
          interval = segment.split('/').map! { |x|
            if x == '*'
              x = data_type.maximum
            else
              x.to_i
            end
          }
          while counter < interval[0]
            values.push(counter)
            counter += interval[1]
          end
        when /[*]/
          values.concat((data_type.minimum .. data_type.maximum).to_a)
        else
          values << segment.to_i
      end
    end
    return values.sort.uniq
  end

  def runs_on?(date_to_check)
    expand_field(self[:month], Months.new).include?(date_to_check.month) &&
    expand_field(self[:days_of_month], DaysOfMonth.new).include?(date_to_check.day) &&
    expand_field(self[:days_of_week], DaysOfWeek.new).include?(date_to_check.wday)
  end

  def runs_today?
    runs_on?(Time.now)
  end

#  def runs_now?
#    runs_today? &&
#    expand_field(self[:hours], Hours.new).include?()
#    expand_field(self[:minutes], Minutes.new).include?()
#  end

  #def to_s
  #  puts "<Job name: %s, value: '%s' >" % [ self[:name], self[:value] ]
  #end

  def to_line
    puts "%s %s %s %s %s %s %s" %
            [ self[:minutes], self[:hours], self[:days_of_month],
              self[:month], self[:days_of_week], self[:user],
              self[:command] ]
  end

end
