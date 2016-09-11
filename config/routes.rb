Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  root "marketing/welcome#index"

  scope module: "marketing" do
    get "/how-it-works", controller: "static_pages", action: "how_it_works"
    get "/slack", controller: "static_pages", action: "slack"

    resources :inquiries
  end

  get '/auth/:provider/callback', controller: "sessions", action: "create"

  resources :registrations, only: [:new, :create]

  scope module: "application" do
    resource :account, only: [:edit, :update] do
      resource :credit_card, path: :billing, except: [:index]
      resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
    end

    resources :stylesheets,
      only: [:create, :destroy, :edit, :index, :new, :show, :update],
      constraints: { id: /[^\/]+/ } do
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

  resque_web_constraint = lambda do |request|
    current_user = request.env['warden'].user
    current_user.can_view_resque? || !Rails.env.production?
  end

  constraints resque_web_constraint do
    mount ResqueWeb::Engine => "/resque_web"
  end

  devise_for :users
end
