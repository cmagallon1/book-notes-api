Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/users' do
    post '/signup', to: 'users#signup'

    post '/signin', to: 'users#signin'

    post '/signout', to: 'users#signout'

    put '/update/:id', to: 'users#update'

    delete '/destroy/:id', to: 'users#destroy'
  end

end
