# See https://relishapp.com/rspec/rspec-core/docs/command-line/rake-task

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  # no rspec available
end
