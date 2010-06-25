require 'time'
require 'date'
require 'khronotab/cron_job_instance'
require 'khronotab/cron_unit'


class CronJob

  attr_accessor :minutes, :hours, :days, :month, :days_of_week, :user, :command, :days_of_month, :job_instance_class

  JOB_REGEX=/([0-9\*\/\-,]+)\s+([0-9\*\/\-,]+)\s+([0-9\*\/\-,]+)\s+([0-9\*\/\-,]+)\s+([0-9\*\/\-,]+)\s+(\S+)\s+(.+)/

  def job_instance_class
    @job_instance_class ||= CronJobInstance
  end

  def self.matches?(ce)
    return false if ce=~/^[\s]*$/ or ce=~/^\s*#/
    !!JOB_REGEX.match(ce)
  end
    
  def self.add_new(cron_entry, job_instance_class=nil)
    return nil unless JOB_REGEX.match(cron_entry)
    minute, hour, dom, month, dow, user, command =
         cron_entry.scan(JOB_REGEX).shift
    ::Job.new(
              :minutes => minute,
              :hours => hour,
              :days_of_month => dom,
              :month => month,
              :days_of_week => dow,
              :user => user,
              :command => command,
              :job_instance_class => job_instance_class 
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

  def expand_times(type=:day)
    case type
    when :day 
      d=Date.today
      return [] unless runs_today?
      hours.expanded_form.map do |hour|
        minutes.expanded_form.map do |minute|
          date_string = "%02i-%02i-%02i %02i:%02i:%02i" % [d.year, d.month, d.day, hour, minute, 0]
          job_instance_class.new(Time.parse(date_string), self.command)
        end
      end
    
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
    @job_instance_class = data[:job_instance_class]
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
