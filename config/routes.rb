Cooperative::Engine.routes.draw do
  root :to => 'pages#show', :as => 'home'
  resources :pages, :except => 'index'
end
