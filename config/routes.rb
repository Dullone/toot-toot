Rails.application.routes.draw do
  devise_for :users, controllers: 
                    { sessions: 'users/sessions', 
                      registrations: 'users/registrations' }
  
  root to: "static_pages#help"
  get "users/usernameAvailable" => "users#usernameAvailable"
  get "users/newFeedToots" => "toots#newFeedToots"

  resources :users do
    resources :toots, except:  [:edit, :update]
    resources :favorites, only: [:create, :destroy]
    resources :follows, only: [:create, :destroy]
  end

  resources :retoots, only: [:create, :destroy]

  get "toots/feed" => "toots#feed"

end
