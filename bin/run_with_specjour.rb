#!/usr/bin/env ruby

SPECJOUR_GEM_PATH = '/home/work/Sites/specjour'
RUBYMINE_PATH = '/opt/RubyMine-132.104'

RUBYMINE_BDD_PATH = "#{RUBYMINE_PATH}/rb/testing/patch/bdd"
RUBYMINE_COMMON_PATH = "#{RUBYMINE_PATH}/rb/testing/patch/common"

SPECJOUR_LIB_PATH = "#{SPECJOUR_GEM_PATH}/lib"

$LOAD_PATH.unshift(RUBYMINE_BDD_PATH)
$LOAD_PATH.unshift(RUBYMINE_COMMON_PATH)
$LOAD_PATH.unshift(SPECJOUR_LIB_PATH)

# Specjour parses options itself. RubyMine will invoke this file like this:
# rspec_runner.rb spec/my_cool_file.rb --require teamcity/spec/runner/formatter/teamcity/formatter --format Spec::Runner::Formatter::TeamcityFormatter
#
# ...but Specjour will parse those options thinking --require is meant for it, and die.
# Instead, we remove these args and tell Specjour about the formatting change ourselves.
4.times do
  ARGV.shift
end

# Add rspec to the beginning of the commands sent to Zeus
ARGV.unshift 'dispatch'

require 'specjour'

$PROGRAM_NAME = File.basename(__FILE__)
Specjour::CLI.start