Rails.application.routes.draw do

  devise_for :users

  resources :gift_cards
  resources :users, only: [:index] do
    member do
      put :make_pending
      put :make_regular
      put :make_admin
    end
  end

  root "gift_cards#index"

end
