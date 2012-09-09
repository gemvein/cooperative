Cooperative::Engine.routes.draw do
  root :to => 'pages#index', :as => 'home'
  resources :pages
end
