Azurie::Application.routes.draw do
  resources :briefings

  get "pages/index", :as => :root

  get "pages/about", :as => :about
  
  get "pages/thanks", :as => :thanks

  resources :questions do
    resources :answers do
      member do
        post :comment
      end
    end
    resources :assignments
    collection do
      get :search
      get :all
      get :pending
      get :unanswered
      get :deleted
    end
    member do
      get :verify
      get :unverify
    end
  end

  devise_for :users, :controllers => { :invitations => 'users/invitations', :omniauth_callbacks => "users/omniauth_callbacks" } do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  resources :users do
    member do
      get :make_expert
      get :make_admin
      get :make_guest
    end
    collection do
      post :fakereg
    end
  end

  root :to => "pages#index"
end
