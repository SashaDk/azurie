Azurie::Application.routes.draw do
  resources :questions

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  resources :users

  root :to => "users#index"
end
