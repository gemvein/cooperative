Cooperative::Engine.routes.draw do
  root :to => 'pages#index', :as => 'home'
  match '/pages/home' => redirect('/')
  match '/pages/*path' => 'pages#show'
  match '/people' => 'people#index', :as => 'people'
  match '/people/:nickname' => 'people#show', :as => 'person', :constraints => {:nickname => /[^\/]+/}
  get '/profile' => 'profile#edit', :as => 'profile'
  put '/profile' => 'profile#update'
end
