Rails.application.routes.draw do

  devise_for :users

  resources :gift_cards, only: [:new, :create] do
    member do
      put :redeem
      put :invalidate
    end
  end

  resources :users, only: [:index] do
    member do
      put :make_pending
      put :make_regular
      put :make_admin
    end
  end

  root "gift_cards#index"

end
