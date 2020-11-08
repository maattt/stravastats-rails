Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'activities#index'
  get '/auth' => "auth#index"
  resources :activities, only: [:index]
end
