module Cooperative
  require 'rails'
  require 'rails-i18n'
  require 'parallel_tests'
  
  require 'cooperative/configuration'
  require 'cooperative/railtie'
  require 'cooperative/engine'
  require 'cooperative/localization'
  require 'cooperative/version'

  require 'haml'
  require 'haml-rails'
  require 'customizable_bootstrap'
  require 'bootstrap_forms'
  require 'bootstrap_leather'
  require 'breadcrumbs_on_rails'

  require 'jquery-rails'
  require 'jquery-ui-rails'
  require 'jquery-ui-bootstrap-rails-asset'
  require 'tinymce-rails'

  require 'bootstrap_pager'

  require 'cancan'
  require 'devise'
  require 'rolify'
  require 'private_person'

  require 'paperclip'
  require 'nokogiri'
  require 'friendly_id'
  require 'chalk_dust'
  require 'acts-as-taggable-on'
  require 'acts_as_opengraph'
  require 'opengraph'
  require 'coletivo'
end