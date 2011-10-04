Azurie::Application.routes.draw do
  resources :briefings

  get "pages/index", :as => :root

  get "pages/about", :as => :about

  resources :questions do
    resources :answers
    resources :assignments
  end

  devise_for :users, :controllers => { :invitations => 'users/invitations', :omniauth_callbacks => "users/omniauth_callbacks" } do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  resources :users do
    member do
      get :make_expert
      get :make_admin
    end
    collection do
      post :fakereg
    end
  end

  root :to => "pages#index"
end
