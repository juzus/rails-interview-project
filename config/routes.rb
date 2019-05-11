Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'questions#dashboard'
  # resources :questions, only: :dashboard, defaults: { format: :html }
  resources :questions, path: '/tenants/:api_key/questions', only: :index, defaults: { format: :json }
end
