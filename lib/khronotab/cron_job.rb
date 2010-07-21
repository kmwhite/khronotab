require 'time'
require 'date'
require 'khronotab/cron_unit'


class CronJob

  attr_accessor :minutes, :hours, :days, :month, :days_of_week, :user, :command, :days_of_month

  JOB_REGEX=/([0-9\*\/\-,]+)\s+([0-9\*\/\-,]+)\s+([0-9\*\/\-,]+)\s+([0-9\*\/\-,]+)\s+([0-9\*\/\-,]+)\s+(\S+)\s+(.+)/

  def self.matches?(ce)
    return false if ce=~/^[\s]*$/ or ce=~/^\s*#/
    !!JOB_REGEX.match(ce)
  end
    
  def self.add_new(cron_entry)
    return nil unless JOB_REGEX.match(cron_entry)
    minute, hour, dom, month, dow, user, command =
         cron_entry.scan(JOB_REGEX).shift
    self.new(
              :minutes => minute,
              :hours => hour,
              :days_of_month => dom,
              :month => month,
              :days_of_week => dow,
              :user => user,
              :command => command
            )
  end

  def [] ac
    return self.send(ac) if self.respond_to?(ac)
    raise 'Unknown key!'
  end

  def []= k,v
    return self.send("#{k}=",v) if self.respond_to?(k)
    raise 'Unknown key!'
  end

  def expand_times(date = Date.today, type = :day)
    case type
    when :day 
      return [] unless runs_on?(date)
      time_list = []
      hours.expanded_form.map do |hour|
        minutes.expanded_form.map do |minute|
          time_list << "%02i-%02i-%02i %02i:%02i:%02i" % [date.year, date.month, date.day, hour, minute, 0]
        end
      end
      return time_list
    end 
  end

  def initialize(data)
    @minutes = CronUnit.new(data[:minutes], 0, 59)
    @hours = CronUnit.new(data[:hours], 0, 23)
    @days_of_month = CronUnit.new(data[:days_of_month], 1, 31)
    @month = CronUnit.new(data[:month], 1, 12)
    @days_of_week = CronUnit.new(data[:days_of_week], 0, 7)
    @user = data[:user]
    @command = data[:command]
  end

  def runs_on?(date_to_check)
    month.contains?(date_to_check.month) &&
    days_of_month.contains?(date_to_check.day) &&
    days_of_week.contains?(date_to_check.wday)
  end

  def runs_today?
    runs_on?(Time.now)
  end

  def to_s
    puts "<Job minutes:%s hours:%s dom:%s month:%s dow:%s user:%s cmd:%s>" %
            [ minutes, hours, days_of_month, month, days_of_week, user,
              command ]
  end

  def to_line
    puts "%s %s %s %s %s %s %s" %
            [ minutes, hours, days_of_month, month, days_of_week, user,
              command ]
  end

end
