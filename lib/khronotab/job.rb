class Job < Hash

  def initialize(data)
    self[:minutes] = data[:minutes]
    self[:hours] = data[:hours]
    self[:days_of_month] = data[:days_of_month]
    self[:month] = data[:month]
    self[:days_of_week] = data[:days_of_week]
    self[:user] = data[:user]
    self[:command] = data[:command]
  end

  def to_s
    puts "<Job name: %s, value: '%s' >" % [ self[:name], self[:value] ]
  end

  def to_line
    puts "%s %s %s %s %s %s %s" %
            [ self[:minutes], self[:hours], self[:days_of_month],
              self[:month], self[:days_of_week], self[:user],
              self[:command] ]
  end

end
