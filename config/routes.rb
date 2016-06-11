Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  root "marketing/welcome#index"

  scope module: "marketing" do
    get "/how-it-works" => "static_pages#how_it_works"
    get "/slack" => "static_pages#slack"
  end

  get '/auth/:provider/callback', to: 'sessions#create'

  resources :registrations, only: [:new, :create]

  scope module: "application" do
    resource :account, only: [:edit, :update] do
      resource :credit_card, path: :billing, except: [:index]
      resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
    end


    resources :stylesheets, only: [:create, :edit, :index, :new, :show, :update] do
      member do
        post :publish
      end

      resource :embed, only: [:show]

      resources :versions, only: [:index]
    end
  end

  namespace :api do
    resource :slack, only: [:create]
  end

  namespace :embed do
    resource :stylesheet, only: [:show], defaults: { format: :js }
  end

  mount ResqueWeb::Engine => "/resque_web"

  devise_for :users
end
