# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:sales]

  def show
    @tortoises = Tortoise.all
    @accessories = Accessory.all
    if current_user
      role = current_user.role.to_sym
      send("set_#{role}_variables")

      if current_user.customer?
        render :show
      else
        render role
      end
    else
      render :show
    end
  end

  def browse_listings
    @tortoises = Tortoise.all
    if params[:filter].present?
        @tortoises = apply_filters(@tortoises, params[:filter])
    end
    @accessories = Accessory.all
  end

  def sales
    acc_sum = Accessory.where(user: current_user).map do |acc|
      acc.quantity * acc.price
    end.sum
    tor_sum = Tortoise.where(user: current_user).map do |tor|
      tor.quantity * tor.price
    end.sum

    orders = Order.includes(:order_items).where(status: :delivered)
    order_items = orders.map(&:order_items).flatten
    items = order_items.map(&:item)

    sold_items = (current_user.accessories + current_user.tortoises) & items

    @sold_price_amount = OrderItem.where(item: sold_items, order_id: orders.delivered.ids).sum(&:price)
    @in_transit_amount = OrderItem.where(item: sold_items, order_id: orders.pending.ids).sum(&:price)

    @total_inventory_amount = acc_sum + tor_sum
  end

  private

  def set_vendor_variables
    @tortoises = current_user.tortoises
    @accessories = current_user.accessories
  end

  def set_admin_variables
  end

  def set_customer_variables
    @chat_session = current_user.chat_sessions.first
  end

  def set_customer_executive_variables
    @chat_sessions = ChatSession.includes(:users).all
  end

  def apply_filters(scope, filters)
    filters.each do |key, value|
        next if value.blank? || value == "All"
        scope = scope.where(key => value)
    end
    scope
  end
end
