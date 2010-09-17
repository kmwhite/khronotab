class CronComment < String

  COMMENT_REGEX=%r{\s*#.*}i

  def self.matches?(cron_entry)
    !!COMMENT_REGEX.match(cron_entry)
  end

  def to_s
    puts self
  end

  def to_line
    puts self
  end

end
