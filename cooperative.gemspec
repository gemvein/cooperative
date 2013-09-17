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
end
