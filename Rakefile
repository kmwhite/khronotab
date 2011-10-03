# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "khronotab"
  gem.homepage = "http://khronotab.kmwhite.net/"
  gem.license = "BSD"
  gem.summary = %Q{A pure ruby interface to the crontab}
  gem.description = %Q{A pure ruby interface to the crontab}
  gem.email = "me@kmwhite.net"
  gem.authors = ["Kristofer M White"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
require 'khronotab'
namespace :rspec do

  desc 'Run Tests'
  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = FileList['spec/**/*_spec.rb']
  end

  desc 'Run Tests in Tree View'
  RSpec::Core::RakeTask.new(:tree) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rspec_opts = %w{-fd}
  end

  desc 'Generate Test Coverage Report'
  RSpec::Core::RakeTask.new(:rcov) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov_opts = %w{--exclude gems\/,spec\/}
    spec.rcov = true
  end

end

require 'reek/rake/task'
Reek::Rake::Task.new do |t|
  t.fail_on_error = true
  t.verbose = false
  t.source_files = 'lib/**/*.rb'
end

require 'roodi'
require 'roodi_task'
RoodiTask.new do |t|
  t.verbose = false
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "khronotab #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
