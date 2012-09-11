module Cooperative
  def self.configure(configuration = Cooperative::Configuration.new)
    if block_given?
      yield configuration
    end
    @@configuration = configuration
  end
  
  def self.configuration
    @@configuration ||= Plugin::Configuration.new
  end
  
  class Configuration
    attr_accessor :application_name, :application_description, :application_keywords
    
    def initialize
      self.application_name = "TODO"
      self.application_description = "TODO"
      self.application_keywords = "TODO"
    end
  end
end