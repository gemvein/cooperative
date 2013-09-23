Specjour::Configuration.rspec_formatter = lambda do
  require 'teamcity/spec/runner/formatter/teamcity/formatter'
  ::Spec::Runner::Formatter::TeamcityFormatter
end
