module Cooperative
  VERSION = File.read(File.expand_path('../../../VERSION', __FILE__))
  
  def self.version_string
    "Cooperative version #{Cooperative::VERSION}"
  end
end
