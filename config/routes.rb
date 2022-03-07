Rails.application.routes.draw do
  devise_for :users

  root 'home#index' , as: 'home'
  get "/auth/twitter/callback" , to: "omniauth_callback#twitter" , as: "callback"

  resources :twitter_accounts
  resources :tweets
  get "/published_tweets" , to: "tweets#published" , as: "published_tweets"
  post "/published_tweets/:id" , to: "tweets#publish" , as: "publish_tweet"
  
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    get '/users/password', to: 'devise/passwords#new'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
