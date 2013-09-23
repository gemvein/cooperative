module Cooperative
  module SharedExamples
    Dir["#{File.dirname(__FILE__)}/behaviors/*_behaviors.rb"].each { |f| require f }

    RSpec::Core::ExampleGroup.send :include, SharedBehaviors

    if defined?(Capybara::Node)
      Capybara::Session.send :include, CapybaraNodeExtensions
      Capybara::Node::Element.send :include, CapybaraNodeExtensions
    end
  end
  module SharedContexts
    def self.included(base)
      base.class_eval do
        Dir["#{File.dirname(__FILE__)}/support/*_support.rb"].each { |f| require f }
      end
    end
  end
end