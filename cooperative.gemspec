$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'cooperative/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cooperative'
  s.version     = Cooperative::VERSION
  s.authors     = ['Karen Lundgren']
  s.email       = ['webmaster@sourcherryweb.com']
  s.homepage    = 'https://github.com/nerakdon/cooperative.git'
  s.summary     = 'Cooperative: A Social Engine'
  s.description = 'Cooperative provides Social Networking abilities to Rails 3 apps.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['LICENSE.txt', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '3.2.14'
  s.add_dependency 'rails-i18n'

  s.add_dependency 'rspec'
  s.add_dependency 'capybara'
  s.add_dependency 'factory_girl_rails'
  s.add_dependency 'database_cleaner', '1.0.1' # problems with sql after this version
  s.add_dependency 'rails-dev-boost'
  
  s.add_dependency 'haml'
  s.add_dependency 'haml-rails'

  s.add_dependency 'sass-rails'
  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'font-awesome-sass-rails'

  s.add_dependency 'bootstrap_forms'
  s.add_dependency 'breadcrumbs_on_rails'
  s.add_dependency 'bootstrap_pager'
  
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'jquery-ui-bootstrap-rails-asset'
  s.add_dependency 'tinymce-rails'
  
  s.add_dependency 'cancan'
  s.add_dependency 'devise'
  s.add_dependency 'authorization'
  s.add_dependency 'private_person'

  s.add_dependency 'paperclip'
  s.add_dependency 'nokogiri'
  s.add_dependency 'friendly_id'
  s.add_dependency 'public_activity'
  s.add_dependency 'acts_as_follower'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'coletivo'

  s.add_development_dependency 'sqlite3'
end
