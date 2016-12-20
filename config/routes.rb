# frozen_string_literal: true
Rails.application.routes.draw do
  filter :locale, exclude: %r{^\/(admin|analytics)}
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Analytics::Engine => '/analytics', as: 'analytics'

  root 'main#index'

  scope module: 'home' do
    resources :user_sessions, only: [:new, :create]
    resources :users, only: [:new, :create]
    get 'login' => 'user_sessions#new', :as => :login

    post 'oauth/callback' => 'oauths#callback'
    get 'oauth/callback' => 'oauths#callback'
    get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  end

  scope module: 'dashboard' do
    resources :user_sessions, only: :destroy
    resources :users, only: :destroy
    delete 'logout' => 'user_sessions#destroy', :as => :logout

    resources :cards
    resources :parsings, only: [:new, :create]

    resources :blocks do
      member do
        put 'set_as_current'
        put 'reset_as_current'
      end
    end

    put 'review_card' => 'trainer#review_card'
    get 'trainer' => 'trainer#index'

    get 'profile/:id/edit' => 'profile#edit', as: :edit_profile
    put 'profile/:id' => 'profile#update', as: :profile
  end

  resources :flickr_search, only: [:index]
end
