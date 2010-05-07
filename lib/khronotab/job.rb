require 'time'

class Job < Hash
  require 'khronotab/cronunit'

  def initialize(data)
    self[:minutes] = CronUnit.new(data[:minutes], 0, 59)
    self[:hours] = CronUnit.new(data[:hours], 0, 23)
    self[:days_of_month] = CronUnit.new(data[:days_of_month], 1, 31)
    self[:month] = CronUnit.new(data[:month], 1, 12)
    self[:days_of_week] = CronUnit.new(data[:days_of_week], 0, 7)
    self[:user] = data[:user]
    self[:command] = data[:command]
  end

  def runs_on?(date_to_check)
    self[:month].contains?(date_to_check.month) &&
    self[:days_of_month].contains?(date_to_check.day) &&
    self[:days_of_week].contains?(date_to_check.wday)
  end

  def runs_today?
    runs_on?(Time.now)
  end

  # Commenting out. Need to write still. --kmwhite 2010-05-06
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
