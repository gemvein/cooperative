Devise.setup do |config|
  config.scoped_views = true

end
Devise::DeviseController.view_paths = CooperativeController.view_paths