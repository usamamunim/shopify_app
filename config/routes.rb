Rails.application.routes.draw do
  root :to => 'home#index'
  # root :to => 'products#index'
  resources :products
  # get '/products', :to => 'products#index'
  # match '/home/edit/:id', to: 'home#edit', as: :home_edit, via: [:get]
  # post '/home/edit', :to => 'home#edit'
  get 'home', :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
