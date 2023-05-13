Rails.application.routes.draw do
  root to: 'despesas#index'

  resources :despesas
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
