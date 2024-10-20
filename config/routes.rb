Rails.application.routes.draw do
  devise_for :users
  root to: 'despesas#index'

  resources :despesas do
    collection do
      get :export_to_json
      get 'import', to: 'despesas#import'
      post 'import', to: 'despesas#import_json'
      post 'update_valor'
      post 'add_despesa'
    end
    member do
      patch 'update_valor'
    end
  end

  resources :investments, only: [:index]
  resources :settings, only: [:index]

  resources :delayed_jobs, only: [:destroy]
  post '/run_delayed_job/:id', to: 'delayed_jobs#run', as: 'run_delayed_job'
  get 'relatorio', to: 'despesas#relatorio'
end
