Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  root "marketing#index"

  resources :registrations, only: [:new, :create]

  scope module: "application" do
    resources :stylesheets, only: [:create, :edit, :index, :new, :show, :update] do
      resources :versions, only: [:index]
    end
  end

  mount ResqueWeb::Engine => "/resque_web"

  devise_for :users
end
