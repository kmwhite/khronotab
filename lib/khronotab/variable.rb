class Variable < Hash

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
