class VariableList < Array

  require 'khronotab/variable'

  def add_new(cron_entry)
    name, value = cron_entry.scan(%r{^([^=]+)=(.+)}).shift
    self << ::Variable.new({ :name => name, :value => value })
  end

end
