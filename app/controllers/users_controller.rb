class UsersController < ApplicationController
  before_action :authenticate_user!

  def account
    @user = current_user
    @addresses = @user.addresses
    @address = Address.new
  end

  # Update account information
  def update_account
    @user = current_user
    if @user.update(user_params)
      respond_to do |format|
        format.html do
          flash[:notice] = "Account information updated successfully."
          redirect_to account_path
        end
        format.turbo_stream do
          flash.now[:notice] = "Account information updated successfully."
          render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash')
        end
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = "Failed to update account information."
          render :account, status: :unprocessable_entity
        end
        format.turbo_stream do
          flash.now[:alert] = "Failed to update account information."
          render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash')
        end
      end
    end
  end

  # Update payment details
  def update_payment_details
    @user = current_user
    if @user.update(payment_params)
      respond_to do |format|
        format.html do
          flash[:notice] = "Payment details updated successfully."
          redirect_to account_path
        end
        format.turbo_stream do
          flash.now[:notice] = "Payment details updated successfully."
          render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash')
        end
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = "Failed to update payment details. Please check the errors."
          render :account, status: :unprocessable_entity
        end
        format.turbo_stream do
          flash.now[:alert] = "Failed to update payment details. Please check the errors."
          render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash')
        end
      end
    end
  end

  # Save or update shipping address
  def save_address
    @address = current_user.addresses.new(address_params)
    if @address.save
      flash[:notice] = "Address saved successfully."
    else
      flash[:alert] = "Failed to save the address. Please check the errors."
    end
    redirect_to account_path
  end


  private

  # Strong parameters for user account updates
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password, :password_confirmation)
  end

  # Strong parameters for payment details updates
  def payment_params
    params.require(:user).permit(:card_holder_name, :card_number, :expiry_date, :cvv)
  end

  # Strong parameters for address management
  def address_params
    params.require(:address).permit(:address_type, :apartment_no, :street, :city, :state, :zip_code)
  end
end

