module Cooperative
  require 'rails'
  require 'rails-i18n'
  require 'parallel_tests'

  # From https://github.com/plataformatec/devise/wiki/How-To:-Use-devise-inside-a-mountable-engine
  # NOTE: If you need to override the standard devise views (i.e. app/views/devise/sessions/new)
  # you will want to require 'devise' before you require your engine. This way the view order will
  # get configured appropriately and you can manage the overrides within your engine rather than the
  # main app.
  require 'devise'
  
  require 'cooperative/configuration'
  require 'cooperative/railtie'
  require 'cooperative/engine'
  require 'cooperative/localization'
  require 'cooperative/version'

  require 'haml'
  require 'haml-rails'
  require 'bootswitch'
  require 'bootstrap_forms'
  require 'bootstrap_leather'
  require 'breadcrumbs_on_rails'

  require 'jquery-rails'
  require 'jquery-ui-rails'
  require 'tinymce-rails'

  require 'bootstrap_pager'

  require 'cancan'
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