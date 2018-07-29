Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/foods', to: 'foods#index'
      get '/foods/:id', to: 'foods#show'
      post '/foods', to: 'foods#create'
      patch '/foods/:id', to: 'foods#update'
      delete '/foods/:id', to: 'foods#destroy'
      get '/meals', to: 'meals#index'
      get '/meals/:id/foods', to: 'meals#show'
    end
  end
end
