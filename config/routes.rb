Rails.application.routes.draw do
  get 'statistics/home'
  get '/home', to: 'statistics#home'
  get '/charts', to: 'statistics#charts'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'statistics#home'
end
