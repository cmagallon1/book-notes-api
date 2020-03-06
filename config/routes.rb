Rails.application.routes.draw do
  post 'users/create'
  get 'users/show'
  post 'users/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
