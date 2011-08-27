module Khronotab
  class CronVariable

    attr_accessor :name, :value

    VAR_REGEX=%r{(^\s*[^#]\w+)=(.+)}i

    def self.matches?(cron_entry)
      !!VAR_REGEX.match(cron_entry)
    end

    def self.parse_new(cron_entry)
      return nil unless VAR_REGEX.match(cron_entry)
      name, value = cron_entry.scan(VAR_REGEX).shift
      self.new( :name => name, :value => value )
    end

    def initialize(data = { :name => nil, :value => nil})
      @name = data[:name]
      @value = data[:value]
    end

    def to_s
      "< CronVariable name: #{self.name}, value: '#{self.value}' >" 
    end

    def to_line
      "#{self.name}=#{self.value}"
    end

  end
end
