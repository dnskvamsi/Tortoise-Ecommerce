class CheckoutController < ApplicationController
    def index
        @cart = current_user.cart # Get the cart associated with the current user
        @cart_items = @cart.cart_items # Fetch the cart items from the cart
        @total_price = @cart_items.sum { |item| item.quantity * item.tortoise.price }
        @discounted_price = session[:discounted_price] || @total_price
    end
    
    def apply_discount
        @cart = current_user.cart # Get the cart associated with the current user
        @cart_items = @cart.cart_items # Fetch the cart items from the cart
        total_price = @cart_items.sum { |item| item.quantity * item.tortoise.price }
    
        if params[:discount_code] == 'DISCOUNT10' || 'SALE10' # Example of discount validation
            discount_rate = 0.1 # 10% discount
            discounted_price = total_price - (total_price * discount_rate)
            session[:discounted_price] = discounted_price
            flash[:notice] = "Discount applied successfully! New total is $#{'%.2f' % discounted_price}."
        else
            session[:discounted_price] = total_price
            flash[:alert] = 'Invalid discount code!'
        end
    
        redirect_to checkout_path
    end
    
    def complete_payment
        if params[:card_number].present? && params[:card_expiry].present? && params[:card_cvv].present?
            cart = current_user.cart
            cart_items = cart.cart_items
            total_price = cart_items.sum { |item| item.quantity * item.tortoise.price }
            discounted_price = session[:discounted_price] || total_price
        
            # Wrap database operations in a transaction for consistency
            ActiveRecord::Base.transaction do
                # Create Order
                order = Order.create!(
                user: current_user,
                status: :pending,
                total_price: total_price,
                discounted_price: discounted_price,
                order_date: Time.current
                )
        
                # Create Order Items
                cart_items.each do |cart_item|
                order.order_items.create!(
                    item_type: 'Tortoise',
                    item_id: cart_item.tortoise.id,
                    quantity: cart_item.quantity,
                    price: cart_item.tortoise.price
                )
                end
        
                # Clear Cart after Order is Placed
                cart.cart_items.destroy_all
            end
        
            flash[:success] = 'Payment successful! Order placed!'
            redirect_to orders_path # Redirect to the orders page
        else
            flash[:error] = 'Payment failed! Please check your card details.'
            redirect_to checkout_path
        end
    end
      

    
end
