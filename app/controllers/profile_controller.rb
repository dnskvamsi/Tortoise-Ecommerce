class ProfileController < ApplicationController
  before_action :authenticate_user!

  def create
    @profile = current_user.profiles.new(params_for_create)
    if @profile.save
      redirect_to profile_index_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(params_for_create)
    flash[:notice] = "Profile details updated successfully."
    redirect_to profile_path(@profile)
  end

  def new
    @profile = Profile.new
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def index
    @profiles = Profile.includes(:user).all
  end

  private

  def params_for_create
    params.require(:profile).permit(:image, :title, :description)
  end
end