Specjour::Configuration.after_fork = lambda do
  require 'rake'
  rakefile = File.expand_path('../../spec/dummy/Rakefile', __FILE__)
  sh("rake -f #{rakefile} db:drop db:test:load") and puts "Reset database #{ENV['TEST_ENV_NUMBER']}"
  Dir.chdir File.expand_path('../../spec/dummy', __FILE__)
end
Specjour::Configuration.rspec_formatter = lambda do
  require 'rspec/core/formatters/documentation_formatter'
  ::RSpec::Core::Formatters::DocumentationFormatter
end
