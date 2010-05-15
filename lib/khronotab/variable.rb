class Variable < Hash

  attr_accessor :name, :value

  VAR_REGEX=%r{^\s*[^#]\w+=.+}i

  def [] ac
    return self.send(ac) if self.respond_to?(ac)
    raise 'Unknown key!'
  end

  def []= k,v
    return self.send("#{k}=",v) if self.respond_to?(k)
    raise 'Unknown key!'
  end

  def self.matches?(ce)
    return false if ce=~/^[\s]*$/ or ce=~/^\s*#/
    !!VAR_REGEX.match(ce)
  end

  def self.add_new(cron_entry)
    return nil unless VAR_REGEX.match(cron_entry)
    self.new(cron_entry)
  end

  def initialize(data)
    name = data[:name]
    value = data[:value]
  end

  def to_s
    puts "<Definition name: %s, value: '%s' >" %
             [ name, value ]
  end

  def to_line
    puts "%s=%s" % [ name, values ]
  end

end
