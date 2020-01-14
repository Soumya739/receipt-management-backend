Rails.application.routes.draw do
  resources :receipt_expense_types
  resources :expense_types
  resources :receipts
  resources :users
  post '/auth', to: 'auth#create'
  get '/current_user', to: 'auth#show'
  post '/user_receipts', to: 'receipts#show_user_receipts'

end
