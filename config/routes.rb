Rails.application.routes.draw do
  post '/game', to: 'game#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
