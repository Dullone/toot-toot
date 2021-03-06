Rails.application.routes.draw do
  devise_for :users, controllers: 
                    { sessions: 'users/sessions', 
                      registrations: 'users/registrations' }
  
  root to: "static_pages#homepage"
  get "users/usernameAvailable" => "users#usernameAvailable"
  get "users/newFeedToots" => "toots#newFeedToots"

  resources :users do
    resources :toots, except:  [:edit, :update] do 
      resources :toot_replies, only: [:create]
    end
    resources :favorites, only: [:create, :destroy, :index]
    resources :follows, only: [:create, :destroy]
    get "following" => "follows#following"
    get "followers" => "follows#followers"
    resources :mentions, only: [:index]
    get :autocomplete_user_at_username, :on => :collection
    get :autocomplete_user_username, :on => :collection
  end

  resources :retoots, only: [:create, :destroy]
  resources :tags, only: [:show]

  get "toots/feed" => "toots#feed"

  get "toot_replies/requestReply" => "toot_replies#requestReply"
  get "search" => "search#search"

end
