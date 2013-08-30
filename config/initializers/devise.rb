Devise.setup do |config|
  config.scoped_views = true
end
Devise::DeviseController.view_paths= File.expand_path('../../../app/views/', __FILE__)