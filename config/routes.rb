Rails.application.routes.draw do
  devise_for :users
  root to: 'despesas#index'

  resources :despesas do
    collection do
      get :export_to_json
      get 'import', to: 'despesas#import'
      post 'import', to: 'despesas#import_json'
    end
  end

  get 'relatorio', to: 'despesas#relatorio'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
