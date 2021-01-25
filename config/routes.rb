Rails.application.routes.draw do
  get '/', to: 'static#home'
  resources :taxons
  resources :documents
  resources :archival_locations
  resources :organizations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
