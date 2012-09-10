module Cooperative
  require 'rails'
  require 'rails-i18n'
  
  require 'rspec'
  require 'capybara'
  require 'factory_girl_rails'
  require 'database_cleaner'
  
  require 'cooperative/configuration'
  require 'cooperative/railtie'
  require 'cooperative/engine'
  require 'cooperative/localization'
  require 'cooperative/version'
  
  require 'haml'
  require 'haml-rails'
  require 'sass-rails'
  require 'bootstrap-sass'
  require 'font-awesome-sass-rails'
  require 'bootstrap_forms'
  
  require 'jquery-rails'
  require 'jquery-ui-rails'
  require 'jquery-ui-themes'
  
  require 'kaminari'
  
  require 'cancan'
  require 'devise'
  require 'authorization'
  
  require 'fastercsv'
  require 'paperclip'
  require 'ckeditor'
  require 'rails_admin'
  
  def self.version_string
    "Cooperative version #{Cooperative::VERSION}"
  end
end