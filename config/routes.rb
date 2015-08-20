Rails.application.routes.draw do
  devise_for :users, controllers: 
                    { sessions: 'users/sessions', 
                      registrations: 'users/registrations' }
  
  root to: "static_pages#help"
  get "users/usernameAvailable" => "users#usernameAvailable"
  get "users/newToots" => "toots#newToots"

  resources :users do
    resources :toots, except:  [:edit, :update]
    resources :favorites, only: [:create, :destroy]
    resources :retoots, only: [:create, :destroy]
  end
end
