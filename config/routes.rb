Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'registrations',
      sessions: :sessions
    }
  root 'top#index'
  resources :users, only: [:index, :show]
end
