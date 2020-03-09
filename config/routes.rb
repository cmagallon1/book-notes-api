Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/users' do

    get '/:id', to: 'users#show'
    
    post '/signup', to: 'users#signup'

    post '/signin', to: 'users#signin'

    post '/signout', to: 'users#signout'

    put '/:id', to: 'users#update'

    delete '/:id', to: 'users#destroy'
  end

end
