class JobList < Array

  require 'khronotab/job'

  def add_new(cron_entry)
    minute, hour, dom, month, dow, user, command = cron_entry.scan(
        %r{^\s*(\d{1,2}|[*]|[-\/,])+\s+(\d{1,2}|[*]|[-\/,])+\s+(\d{1,2}|[*]|[-\/,])+\s+(\d{1,2}|[*]|[-\/,])+\s+(\d{1,2}|[*]|[-\/,])+\s+(\w+)\s+(.+)}).shift
    self << ::Job.new(
              :minutes => minute,
              :hours => hour,
              :days_of_month => dom,
              :month => month,
              :days_of_week => dow,
              :user => user,
              :command => command
            )
  end

end
