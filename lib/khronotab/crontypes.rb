class Minutes
  attr_accessor :maximum, :minimum
  def initialize
    @minimum = 0
    @maximum = 59
  end
end

class Hours
  attr_accessor :maximum, :minimum
  def initialize
    @minimum = 0
    @maximum = 23
  end
end

class DaysOfMonth
  attr_accessor :maximum, :minimum
  def initialize
    @minimum = 1
    @maximum = 31
  end
end

class Months
  attr_accessor :maximum, :minimum
  def initialize
    @minimum = 1
    @maximum = 12
  end
end

class DaysOfWeek
  attr_accessor :maximum, :minimum
  def initialize
    @minimum = 0
    @maximum = 7
  end
end
