Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets, only: [:index]

  devise_scope :user do
  	get 'users/sessions/profile', to: 'users/sessions#profile'
  end

  get 'follows/follow_user', to: 'follows#follow_user'
  root to: 'users/sessions#new'
end
