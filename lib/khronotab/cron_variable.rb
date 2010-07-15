class CronVariable < Hash

  attr_accessor :name, :value

  VAR_REGEX=%r{(^\s*[^#]\w+)=(.+)}i

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
    name, value = cron_entry.scan(VAR_REGEX).shift
    self.new( :name => name, :value => value )
  end

  def initialize(data)
    @name = data[:name]
    @value = data[:value]
  end

  def to_s
    puts "< CronVariable name: %s, value: '%s' >" %
             [ self.name, self.value ]
  end

  def to_line
    puts "%s=%s" % [ self.name, self.values ]
  end

end
