Rails.application.routes.draw do
  root "projects#index"

  resources :projects do
    resources :tasks
  end

  resources :users, only: %i[new create]
  resource :sessions, only: %i[new create show]
end
