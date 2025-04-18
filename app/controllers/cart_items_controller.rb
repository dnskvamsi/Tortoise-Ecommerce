class CartItemsController < ApplicationController
    before_action :authenticate_user!

    def create
        # Ensure the user has a cart
        cart = current_user.cart || current_user.create_cart

        if params[:tortoise_id]
            tortoise = Tortoise.find(params[:tortoise_id])
            quantity = params[:quantity].to_i

            # Find or initialize the cart item
            cart_item = cart.cart_items.find_or_initialize_by(tortoise: tortoise)
        
            if cart_item.new_record?
                cart_item.quantity = quantity
                cart_item.price = quantity * tortoise.price
            else
                cart_item.quantity = quantity
                cart_item.price = quantity * tortoise.price
            end
        
            if cart_item.save
                redirect_to cart_path, notice: "#{tortoise.name} has been added to your cart."
            else
                redirect_to browse_listings_path, alert: "Failed to add #{tortoise.name} to your cart."
            end
        elsif params[:accessory_id]
            accessory = Accessory.find(params[:accessory_id])
            quantity = params[:quantity].to_i

            # Find or initialize the cart item
            cart_item = cart.cart_items.find_or_initialize_by(accessory: accessory)
        
            if cart_item.new_record?
                cart_item.quantity = quantity
                cart_item.price = quantity * accessory.price
            else
                cart_item.quantity = quantity
                cart_item.price = quantity * accessory.price
            end
        
            if cart_item.save
                redirect_to cart_path, notice: "#{accessory.name} has been added to your cart."
            else
                redirect_to browse_listings_path, alert: "Failed to add #{accessory.name} to your cart."
            end
        else
            redirect_to browse_listings_path, alert: "Failed to add Item to your cart."
        end
    end

    def update
        cart_item = current_user.cart.cart_items.find(params[:id])
        new_quantity = params[:cart_item][:quantity].to_i

        if cart_item.update(quantity: new_quantity)
            redirect_to cart_path, notice: "Cart item updated successfully."
        else
            redirect_to cart_path, alert: "Failed to update cart item."
        end
    end

    def destroy
        cart_item = current_user.cart.cart_items.find(params[:id])
    
        if cart_item.destroy
          redirect_to cart_path, notice: "Item removed from your cart."
        else
          redirect_to cart_path, alert: "Failed to remove the item."
        end
    end
end
