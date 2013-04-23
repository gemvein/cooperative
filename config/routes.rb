Cooperative::Engine.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  match '/pages/home' => redirect('/')
  match '/pages/*path' => 'pages#show'
  match '/people' => 'people#index', :as => 'people'
  match '/people/:nickname' => 'people#show', :as => 'person', :constraints => {:nickname => /[^\/]+/}
  get '/profile' => 'profile#edit', :as => 'profile'
  put '/profile' => 'profile#update'
  
  resources :messages, :only => [:index, :show, :new, :create] do
    member do
      get 'reply'
      get 'move_to_trash'
      get 'restore'
    end
    collection do
      get 'sent'
      get 'trash'
    end
  end
end
