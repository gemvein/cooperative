# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  config.scoped_views = true
end
Devise::DeviseController.view_paths= File.expand_path('../../../app/views/', __FILE__)
