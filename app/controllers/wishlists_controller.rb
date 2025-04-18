class WishlistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @wishlist_tortoises = current_user.wishlist_tortoises
    @wishlist_accessories = current_user.wishlist_accessories
  end


  def create
    if params[:tortoise_id]
      tortoise = Tortoise.find(params[:tortoise_id])
      wishlist_item = current_user.wishlists.find_or_create_by(tortoise: tortoise)

      if wishlist_item.persisted?
        redirect_to wishlists_path, notice: "#{tortoise.name} has been added to your wishlist."
      else
        redirect_to browse_listings_path, alert: "Failed to add #{tortoise.name} to your wishlist."
      end
      return
    elsif params[:accessory_id]
      accessory = Accessory.find(params[:accessory_id])
      wishlist_item = current_user.wishlists.find_or_create_by(accessory: accessory)

      if wishlist_item.persisted?
        redirect_to wishlists_path, notice: "#{accessory.name} has been added to your wishlist."
      else
        redirect_to browse_listings_path, alert: "Failed to add #{accessory.name} to your wishlist."
      end
    end
  end

  def destroy
    wishlist_item = current_user.wishlists.find_by(id: params[:id])
    if wishlist_item
      wishlist_item.destroy
      redirect_to wishlists_path, notice: "Item removed from your wishlist."
    else
      redirect_to wishlists_path, alert: "Item not found in your wishlist."
    end
  end
end
