Gem::Specification.new do |s|
  s.name = %q{khronotab}
  s.version = "0.7.5"
  s.date = %q{2010-04-26}
  s.authors = ["Kristofer M White"]
  s.email = %q{me@kmwhite.net}
  s.summary = %q{A pure ruby crontab parser}
  s.homepage = %q{http://www.kmwhite.net//}
  s.description = %q{Khronotab provides a pure ruby interface to crontab, allowing the reading and writing of tabs with a hash-like interface}
  s.files = Dir['lib/**/*'] + Dir['demo/**/*']
  s.files << Dir['[A-Z]*'].shift
  s.files.reject! { |fn| fn.include?("git") }
end
