require 'date'

class Job < Hash
  require 'khronotab/crontypes'

  def initialize(data)
    self[:minutes] = convert_field(data[:minutes], Minutes.new)
    self[:hours] = convert_field(data[:hours], Hours.new)
    self[:days_of_month] = convert_field(data[:days_of_month], DaysOfMonth.new)
    self[:month] = convert_field(data[:month], Months.new)
    self[:days_of_week] = convert_field(data[:days_of_week], DaysOfWeek.new)
    self[:user] = data[:user]
    self[:command] = data[:command]
  end

  def convert_field(cron_data, data_type)
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
            count = 0
            interval = segment.split('/').map! { |x|
              if x == '*'
                x = data_type.maximum
              else
                x.to_i
              end
            }
            values.push(count += interval[1]) while count < interval[0]
          when /[*]/
            values.concat((data_type.minimum .. data_type.maximum).to_a)
          else
            values << segment
        end
      end
    return values
  end

  def runs_on?(date_to_check)
    puts date_to_check.to_s
    true
  end

  def runs_today?
    runs_on?(Date.today)
  end

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
