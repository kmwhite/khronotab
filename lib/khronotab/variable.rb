class Variable < Hash
  VAR_REGEX=%r{^\s*[^#]\w+=.+}i
  def self.matches?(ce)
    return false if ce=~/^[\s]*$/ or ce=~/^\s*#/
    !!VAR_REGEX.match(ce)
  end

  def self.add_new(cron_entry)
    return nil unless VAR_REGEX.match(cron_entry)
    self.new(cron_entry)
  end
  def initialize(data)
    self[:name] = data[:name]
    self[:value] = data[:value]
  end

  def to_s
    puts "<Definition name: %s, value: '%s' >" %
             [ self[:name], self[:value] ]
  end

  def to_line
    puts "%s=%s" % [ self[:name], self[:values] ]
  end

end
