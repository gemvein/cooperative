Cooperative::Engine.routes.draw do

  root :to => 'pages#index', :as => 'home'
  match '/pages/home' => redirect('/')
  match '/pages/*path' => 'pages#show', :as => 'show'

  get '/profile' => 'profile#edit', :as => 'profile'
  put '/profile' => 'profile#update'

  resources :activities, :only => [:index]

  resources :comments, :only => [:create, :destroy, :new, :show]
  resources :statuses, :only => [:create, :destroy, :new, :show] do
    collection do
      get 'grab'
    end
    member do
      get 'rate/:rating', :to => 'ratings#rate', :as => 'rate', :constraints => { :rating => /\-?[0-9]+(\.[0-9])?/ }
      get 'unrate', :to => 'ratings#unrate', :as => 'unrate'
    end
    resources :comments, :only => [:index]
  end

  resources :tags, :only => [:index, :show]
  
  resources :groups do
    member do 
      get 'join'
      get 'leave'
    end
  end
  
  resources :people, :only => [:index, :show] do
    member do
      get 'followers' => 'follows#followers'
    end
    resources :follows, :only => [:create, :destroy, :index]
    resources :pages, :except => [:show]
    match 'pages/*path' => 'pages#show', :as => 'show'
  end

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
