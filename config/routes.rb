Cooperative::Engine.routes.draw do

  root :to => 'activities#index', :as => 'home'
  match '/pages/*path' => 'pages#show', :via => 'get', :as => 'show'

  get '/profile' => 'profile#edit', :as => 'profile'
  put '/profile' => 'profile#update'

  resources :activities, :only => [:index]

  resources :comments, :only => [:create, :destroy]
  resources :statuses, :only => [:create, :destroy, :new, :show] do
    collection do
      get 'grab'
    end
    member do
      get 'rate/:rating', :to => 'ratings#rate', :as => 'rate', :constraints => { :rating => /\-?[0-9]+(\.[0-9])?/ }
      get 'unrate', :to => 'ratings#unrate', :as => 'unrate'
    end
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
      delete 'follows' => 'follows#destroy'
    end
    resources :follows, :only => [:create, :index]
    resources :pages, :except => [:show, :index]
    match 'pages/*path' => 'pages#show', :via => 'get', :as => 'show'
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
