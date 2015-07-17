Rails.application.routes.draw do
  devise_for :users, controllers: 
                    { sessions: 'users/sessions', 
                      registrations: 'users/registrations' }
  
  root to: "static_pages#help"

  resources :users do
    resources :toots, except:  [:edit, :update]
  end
end
