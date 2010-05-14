require 'time'


class JobInstance
  attr_accessor :time, :command
  def initialize(itime,cmd)
    self.time=itime
    self.command=cmd
  end
    
end
class CnuCronJobInstance < JobInstance
  CLUSTERS={
    :uk => /CNU_GB/,
    :us => /CNU_US/,
    :au => /CNU_AU/,
    :jv => /CNU_US[^_]/
  }
  CLUSTERS.each_pair do |(cl,reg)|
  self.class_eval "
  def #{cl}?
    !!CLUSTERS[:#{cl}].match(command)
  end
  "

  end
end


