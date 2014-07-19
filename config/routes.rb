GetvouchedCom::Application.routes.draw do
  resources :jobs do
    get :preview, :on => :member
  end
  resources :educations
  resources :employments
  resources :messages do
    get :preview, :on => :member
  end

  resources :translations
  resources :phrases

  resources :companies
  resources :schools
  resources :regions
  resources :cities
  resources :countries do 
    resources :regions do
      resources :cities
    end
  end
  resources :industries do
    resources :subindustries
  end
  resources :list_types

  match 'about' 	   => 'pages#about',         :as => :about
  match 'home' 	   => 'pages#home',          :as => :home
  match 'help' 	   => 'pages#help',          :as => :help
  match 'privacy' 	   => 'pages#privacy',       :as => :privacy
  match 'press' 	   => 'pages#press',         :as => :press
  match 'service' 	   => 'pages#service',       :as => :service
  match 'access_denied' => 'pages#access_denied', :as => :access_denied
  match 'root'          => 'pages#home',          :as => :root
  match '/'             => 'pages#index',         :as => :index

  match '/auth/:provider/callback'  => 'identities#create'

  devise_for :users, :path_names => { :sign_up => 'register', :sign_in => 'login', :sign_out => 'logout' }, :controllers => {:registrations => 'registrations'} 

  resources :user_profiles

  resources :users do
    resources :vouches do
      get :request, :on => :collection
      get :preview, :on => :member
    end
    resources :vouches_requested
  end

  devise_for :identities, :controllers => {:confirmations => "confirmations"}

  resources :identities do
    resources :vouches , :except => [:edit, :show] do
      get :autocomplete_term_name, :on => :collection
      get :preview, :on => :member
    end
    get :preview, :on => :member
  end

  resources :oauth_consumers do
    get :callback, :on => :member
  end

  resources :contacts do
    get :autocomplete_for_contact_email, :on => :collection
  end  

  match 'contacts/import/:type', :to => 'contacts#import'

  resources :archetypes do
    collection do 
      post :autocomplete
    end
    member do 
      get :vouches
    end
  end

  resource :terms do
    member do 
      post :autocomplete
    end
    member do 

    end
  end

  resource :search, :only => [:show] do
    member do 
      post :autocomplete
    end
  end

  resources :identity_image, :only => [:show]
  resources :vouches do
    get :preview, :on => :member
  end
end
