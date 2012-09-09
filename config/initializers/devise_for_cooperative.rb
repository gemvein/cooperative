# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|

end
Devise::SessionsController.view_paths= File.expand_path('../../../app/views/', __FILE__)
