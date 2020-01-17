Rails.application.routes.draw do
  resources :receipt_expense_types
  resources :expense_types
  resources :receipts
  resources :users
  post '/auth', to: 'auth#create'
  post '/current_user', to: 'users#show_current_user'
  post '/user_receipts', to: 'receipts#show_user_receipts'
  post '/filtered_receipts', to: 'receipts#get_filtered_receipts_data'
  post '/stores', to: 'receipts#get_all_user_stores'
end
