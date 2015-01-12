Rails.application.routes.draw do

  devise_for :users

  resources :gift_cards

  root "gift_cards#index"

end
