Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/auth' => "auth#index"
  delete '/logout' => "auth#destroy"

  resources :activities, only: [:index]
end
