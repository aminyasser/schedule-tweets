Rails.application.routes.draw do
  devise_for :users

  root 'home#index' , as: 'home'
  get "/auth/twitter/callback" , to: "omniauth_callback#twitter" , as: "callback"

  resources :twitter_accounts
  resources :tweets

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
