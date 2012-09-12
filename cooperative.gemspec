$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cooperative/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cooperative"
  s.version     = Cooperative::VERSION
  s.authors     = ["Karen Lundgren"]
  s.email       = ["webmaster@sourcherryweb.com"]
  s.homepage    = "https://github.com/nerakdon/cooperative.git"
  s.summary     = "Cooperative: A Social Engine"
  s.description = "Cooperative provides Social Networking abilities to Rails 3 apps."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "rails-i18n"
  s.add_dependency "factory_girl_rails", '1.7.0'
  s.add_dependency "database_cleaner"
  
  s.add_dependency "haml"
  s.add_dependency "haml-rails"
  s.add_dependency "sass-rails"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "font-awesome-sass-rails"
  s.add_dependency "bootstrap_forms"
  
  s.add_dependency "jquery-rails", ">=2.1.2"
  s.add_dependency "jquery-ui-rails"
  s.add_dependency "jquery-ui-themes"
  
  s.add_dependency "kaminari"
  
  s.add_dependency "cancan"
  s.add_dependency "devise"
  s.add_dependency "authorization"
  
  
  s.add_dependency "fastercsv"
  s.add_dependency "paperclip", ">=2.7.0"
  s.add_dependency "ckeditor"
  s.add_dependency "rails_admin"
  
  s.add_dependency "friendly_id"

  s.add_development_dependency "sqlite3"
end
