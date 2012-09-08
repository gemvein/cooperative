module Cooperative
  class UninstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    require File.expand_path('../../utils', __FILE__)
    include Generators::Utils
    
    def goodbye
      output "Goodbye -- Sorry to see you go.", :magenta
    end
    
    # all public methods in here will be run in order
    def remove_initializer
      output "Removing Initializer"
      remove_file "config/initializers/cooperative.rb"
    end
    
    def tell_to_uninstall_rails_admin
      output "To uninstall Rails Admin, do `rails g rails_admin:uninstall`"
    end
  end
end