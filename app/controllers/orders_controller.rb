class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:track, :cancel]

  def index
    @orders = current_user.orders # Fetch all orders of the current user
    @tortoise = Tortoise.find(params[:tortoise_id]) if params[:tortoise_id]
  end

  def track
    @order = Order.find(params[:id]) # Fetch the specific order by ID

    # Determine the status of the order
    if @order.created_at >= 2.days.ago
      @status = "Order has not been shipped"
      @can_cancel = true
    else
      @status = "Order has been shipped"
      @can_cancel = false
    end
  end


  def show
    @order = Order.includes(:order_items).find(params[:id])
  end

  def cancel
    if @order.created_at >= 2.days.ago
      @order.update(status: :cancelled) # Cancel the order from the database
      flash[:success] = "Order has successfully been cancelled"
    else
      flash[:error] = "Order cannot be canceled as it has already been shipped"
    end
    redirect_to orders_path # Redirect to the orders page
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

end
