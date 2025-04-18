class CartsController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @cart = current_user.cart || current_user.create_cart
      @cart_items = @cart.cart_items.includes(:tortoise, :accessory) # Preloading to reduce queries
    end
  end
  