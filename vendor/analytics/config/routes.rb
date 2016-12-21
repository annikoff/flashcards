# frozen_string_literal: true
Analytics::Engine.routes.draw do
  resources :charts, only: [:index, :visits, :events] do
    collection do
      get :visits
      get :events
    end
  end
end
