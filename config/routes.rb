Rails.application.routes.draw do
  resource :login, only: [:show, :create]
  get '/logout' => 'logins#destroy'
  resources :expenses, path: '', only: [:index, :create]
  get '/expenses/:id/destroy' => 'expenses#destroy', as: :destroy_expense
end
