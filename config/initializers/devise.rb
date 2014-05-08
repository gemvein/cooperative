Devise.setup do |config|
  config.scoped_views = true
  config.router_name = :cooperative
  config.parent_controller = 'CooperativeController'
end
Devise::DeviseController.view_paths = CooperativeController.view_paths