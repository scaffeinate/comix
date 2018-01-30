Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/superheros/:universe' => 'superheros#index'
      get '/superhero/:id' => 'superheros#show'
      get '/autocomplete' => 'autocomplete#index'
    end
  end
end
