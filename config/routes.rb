ImmonetCheater::Application.routes.draw do
  resources :immonet_links

  resources :immonet_mails

  devise_for :users

  root "immonet_mails#index"
end
