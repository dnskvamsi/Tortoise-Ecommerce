Rails.application.routes.draw do
  # Root route
  root  to: 'home#show'

  # Home Page
  get 'home', to: 'home#show', as: 'home'

  # Browse and Filter Tortoises
  get 'home/browselistings', to: 'home#browse_listings', as: 'browse_listings'
  get 'home/browselistings/:id', to: 'tortoises#show', as: 'show'
  get 'home/sales', to: 'home#sales', as: 'sales'

  # Standard resourceful routes for Tortoises
  resources :tortoises, only: [:show, :new, :create, :edit, :update] do
    get 'related', on: :collection
  end

  resources :accessory, only: [:show, :new, :create, :edit, :update] do
    get 'related', on: :collection
  end

  # Wishlist Routes
  resources :wishlists, only: [:index, :create, :destroy]
  resources :reviews, only: [:new, :create]
  resources :support, only: [:new, :index, :create]
  resources :chat_session, only: [:show, :create, :index]
  resources :profile, only: [:index, :new, :create, :show, :edit, :update]
  post "chat_session/add_participant", to: 'chat_session#add_participant', as: 'add_participant'


  # User Account Routes
  get 'account', to: 'users#account', as: 'account'
  patch 'update_account', to: 'users#update_account'
  patch 'update_payment_details', to: 'users#update_payment_details'

  # Address Routes
  resources :addresses, only: [:create, :update, :destroy]
  get 'my_address', to: 'users#account', as: 'my_address'


  # Devise routes for user authentication
  devise_for :users

  # Shopping Cart
  resource :cart, controller: 'carts', only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]
  post 'message/create', to: 'message#create'

  get 'checkout', to: 'checkout#index', as: 'checkout'
  post 'complete_payment', to: 'checkout#complete_payment', as: 'complete_payment'
  get 'apply_discount', to: 'checkout#apply_discount', as: 'apply_discount'

  #Orders
  get 'orders/confirm', to: 'orders#confirm', as: 'order_confirmation'

  resources :orders, only: [:show, :index]

  #Track Order
  get '/orders/:id/track', to: 'orders#track', as: 'track_order'
  resources :orders do
    member do
      patch :cancel # Add a cancel action
    end
  end

  post "like/:id",to: "likes#create", as: :like
  delete "dislike/:id",to: "likes#destroy", as: :dislike
  post "follow/:id",to: "follows#create", as: :follow
  delete "follow/:id",to: "follows#destroy", as: :unfollow

  post '/answer', to: 'answer#create'
  post '/faq', to: 'faq#create'
  get 'faq/index'
  post "comment/create", to: 'comment#create'

  post '/users/save_address', to: 'users#save_address'
end