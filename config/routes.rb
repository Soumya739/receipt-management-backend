Rails.application.routes.draw do
  resources :receipt_expense_types
  resources :expense_types
  resources :receipts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
