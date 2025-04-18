class AccessoryController < ApplicationController
  before_action :authenticate_user!

  def new
    @accessory = Accessory.new
  end

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def create
    @accessory = current_user.accessories.create(params_for_create)
    flash[:notice] = "Accessory successfully created"
    redirect_to(root_path)
  end

  def update
    @accessory = Accessory.find(params[:id])
    @accessory.update(params_for_create)
    flash[:notice] = "Accessory updated successfully"
    redirect_to(root_path)
  end

  def show
    @accessory = Accessory.find(params[:id])
    @related_accessories = Accessory.where.not(id: @accessory.id)
  end

  private

  def params_for_create
    params.require(:accessory).permit(:name, :gender, :price, :quantity)
  end
end
