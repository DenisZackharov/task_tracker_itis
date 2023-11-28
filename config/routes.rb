require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?

  post "/graphql", to: "graphql#execute"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :projects, only: %i[index create update destroy] do
        resources :tasks, only: %i[index create update destroy]
      end
    end
  end

  root "projects#index"
  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  get "register", to: "users#new", as: :register
  post "register", to: "users#create"

  resources :projects do
    resources :tasks do
      resources :comments, only: %i[create destroy update edit]
    end
  end

  resources :users, only: %i[new create]
  resource :sessions, only: %i[new create show]
end
