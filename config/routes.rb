Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    post 'auth/login', to: 'authentication#authenticate'
    post 'signup', to: 'users#create'
    get 'users/current', to: 'users#user'
    get 'users', to: 'users#users'
    put 'users/current/password', to: 'users#update_password'
    resources :costs
  end


end
