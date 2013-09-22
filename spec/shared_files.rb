module Cooperative
  module SharedExamples
    def self.included(base)
      base.class_eval do
        begin
          Dir["#{File.dirname(__FILE__)}/behaviors/**/*.rb"].each { |f| require f }

          if defined?(Capybara::Node)
            Capybara::Session.send :include, CapybaraNodeExtensions
            Capybara::Node::Element.send :include, CapybaraNodeExtensions
          end
        rescue ArgumentError => e
          # ignore the "duplicate shared behavior name error" when running in normal, *single-threaded* mode
          raise e unless e.message =~ /already exists/
        end
      end
    end
  end
  module SharedContexts
    def self.included(base)
      base.class_eval do
        begin
          Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
        rescue ArgumentError => e
          # ignore the "duplicate shared behavior name error" when running in normal, *single-threaded* mode
          raise e unless e.message =~ /already exists/
        end
      end
    end
  end
end