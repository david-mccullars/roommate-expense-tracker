Rails.application.routes.draw do
  scope format: false do

    scope :api do
      get :logins, to: 'logins#show'
      post :logins, to: 'logins#create'
      resources :expenses, only: [:index, :create, :destroy]
      get '/expenses/:month', to: 'expenses#index'
    end

    get '/', to: 'application#index'
#    get '/environment/:name', to: 'application#index'
#    get '/user/:user', to: 'application#index', constraints: { user: /.*/ }
#    get '/token/:token', to: 'application#index', constraints: { token: /.*/ }
    get '/bundle.js', to: 'application#bundle_js' if Rails.env.development?

  end
end
