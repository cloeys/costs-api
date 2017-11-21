Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :costs
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  match '*path', via: [:options], to: lambda {|_| [204, { 'Access-Control-Allow-Headers' => "Origin, Content-Type, Accept, Authorization, Token", 'Access-Control-Allow-Origin' => "*", 'Content-Type' => 'text/plain' }, []]}
end

