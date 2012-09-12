Cooperative::Engine.routes.draw do
  root :to => 'pages#index', :as => 'home'
  match '/pages/home' => redirect('/')
  match '/pages/*path' => 'pages#show'
end
