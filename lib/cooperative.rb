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
  require 'breadcrumbs_on_rails'
  
  require 'jquery-rails'
  require 'jquery-ui-rails'
  require 'jquery-ui-themes'
  require 'tinymce-rails'
  
  require 'kaminari'
  
  require 'cancan'
  require 'devise'
  require 'authorization'
  
  require 'fastercsv'
  require 'paperclip'
  require 'ckeditor'
  require 'safe_yaml'
  require 'rails_admin'
  
  require 'friendly_id'

  require 'public_activity'
  require 'acts_as_follower'
  require 'merit'

end