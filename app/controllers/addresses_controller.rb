class AddressesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_address, only: %i[update destroy]
  
    def create
      @address = current_user.addresses.new(address_params)
      if @address.save
        flash[:notice] = "Address saved successfully."
        respond_to do |format|
          format.html { redirect_to account_path(anchor: 'my-address') }
          format.turbo_stream { render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash') }
        end
      else
        flash.now[:alert] = "Failed to save address. Please check the errors."
        respond_to do |format|
          format.html { render 'users/account', status: :unprocessable_entity }
          format.turbo_stream { render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash') }
        end
      end
    end

    def update
      if @address.update(address_params)
        flash[:notice] = "Address updated successfully."
        respond_to do |format|
          format.html { redirect_to account_path(anchor: 'my-address') }
          format.turbo_stream { render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash') }
        end
      else
        flash.now[:alert] = "Failed to update address. Please check the errors."
        respond_to do |format|
          format.html { render 'users/account', status: :unprocessable_entity }
          format.turbo_stream { render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash') }
        end
      end
    end
  
    def destroy
      if @address.destroy
        flash[:notice] = "Address deleted successfully."
      else
        flash[:alert] = "Failed to delete address."
      end
      respond_to do |format|
        format.html { redirect_to account_path(anchor: 'my-address') }
        format.turbo_stream { render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash') }
      end
    end
  
    private
  
    def find_address
      @address = current_user.addresses.find_by(id: params[:id])
      unless @address
        flash[:alert] = "Address not found."
        respond_to do |format|
          format.html { redirect_to account_path(anchor: 'my-address') }
          format.turbo_stream { render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash') }
        end
      end
    end
  
    def address_params
      params.require(:address).permit(:apartment_no, :street_address, :city, :state, :pin_code, :address_type)
    end
  end