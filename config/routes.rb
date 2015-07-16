Rails.application.routes.draw do
  devise_for :users
  
  root to: "static_pages#help"

  resources :users do
    resources :toots, except:  [:edit, :update]
  end
end
