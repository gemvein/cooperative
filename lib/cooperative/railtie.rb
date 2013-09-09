module Cooperative
  class Railtie < Rails::Railtie
    initializer 'cooperative.overwrite_bootstrap_leather_config', :after => :load_config_initializers do |app|
      BootstrapLeather.configure do |config|
        config.application_path = '/'
        config.application_title = Cooperative.configuration.application_name
        config.application_description = Cooperative.configuration.application_description
        config.application_keywords = Cooperative.configuration.application_keywords
      end
    end
  end
end