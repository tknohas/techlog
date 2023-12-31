Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: "home#index"
  resources :posts, only: [:new, :create, :show, :index, :destroy]
end
