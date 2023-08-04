Rails.application.routes.draw do
  devise_for :users
  root to: 'despesas#index'

  resources :despesas do
    get :export_to_json, on: :collection
  end
  
  get 'relatorio', to: 'despesas#relatorio'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
