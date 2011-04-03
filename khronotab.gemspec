# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{khronotab}
  s.version = "1.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristofer M White"]
  s.date = %q{2010-11-09}
  s.description = %q{A pure ruby crontab parser with a Hash-like interface}
  s.email = %q{me@kmwhite.net}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "demo/sample.ct",
     "demo/sample.rb",
     "khronotab.gemspec",
     "lib/khronotab.rb",
     "lib/khronotab/cron_comment.rb",
     "lib/khronotab/cron_job.rb",
     "lib/khronotab/cron_unit.rb",
     "lib/khronotab/cron_variable.rb",
     "test/helper.rb",
     "test/tc_cron_job_command-length.rb",
     "test/tc_cron_job_different-time-arguments.rb",
     "test/tc_cron_job_nil-checks.rb",
     "test/test_khronotab.rb",
     "test/ts_cron_job.rb",
     "test/ts_cron_tab.rb",
     "test/ts_cron_unit.rb",
     "test/ts_cron_variable.rb"
  ]
  s.homepage = %q{http://github.com/kmwhite/khronotab}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A pure ruby crontab parser with a Hash-like interface}
  s.test_files = [
    "test/tc_cron_job_nil-checks.rb",
     "test/ts_cron_variable.rb",
     "test/ts_cron_job.rb",
     "test/test_khronotab.rb",
     "test/tc_cron_job_different-time-arguments.rb",
     "test/tc_cron_job_command-length.rb",
     "test/ts_cron_unit.rb",
     "test/ts_cron_tab.rb",
     "test/helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
  end
end

