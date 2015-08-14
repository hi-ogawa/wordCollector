require 'api_constraints'

Rails.application.routes.draw do

  get '/', to: redirect('/')

  namespace :api, defaults: {format: :json} do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :categories, :only => [:index, :show, :create, :update, :destroy]
      resources :items, :only => [:index, :show, :create, :update, :destroy]
    end
  end
end
