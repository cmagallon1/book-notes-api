Rails.application.routes.draw do
  scope '/users' do
    delete '/signout', to: 'sessions#destroy'
    post '/signin', to: 'sessions#create'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    resources :books
  end
end
