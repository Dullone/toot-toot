Rails.application.routes.draw do
  devise_for :users, controllers: 
                    { sessions: 'users/sessions', 
                      registrations: 'users/registrations' }
  
  root to: "static_pages#help"
  get "users/usernameAvailable" => "users#usernameAvailable"
  get "users/newFeedToots" => "toots#newFeedToots"

  resources :users do
    resources :toots, except:  [:edit, :update] do 
      resources :toot_replies, only: [:create]
    end
    resources :favorites, only: [:create, :destroy]
    resources :follows, only: [:create, :destroy]
    get "following" => "follows#following"
    get "followers" => "follows#followers"
    resources :mentions, only: [:index]
  end

  resources :retoots, only: [:create, :destroy]

  get "toots/feed" => "toots#feed"

  get "toot_replies/requestReply" => "toot_replies#requestReply"

end
