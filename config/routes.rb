Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  namespace :api do
    resources :posts, only: [:index]
    get 'posts/search', to: 'posts#search'
  end
end
