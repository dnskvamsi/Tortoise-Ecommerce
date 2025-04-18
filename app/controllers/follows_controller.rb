class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
      @profile = Profile.find(params[:id])
      current_user.follows.create(profile: @profile) unless @profile.follows.find_by(user: current_user)
      render turbo_stream: turbo_stream.update("follow_profile_#{@profile.id}".to_sym, nil, partial:"shared/follows", locals: {profile: @profile, following: true})
  end

  def destroy
      @profile = Profile.find(params[:id])
      @profile.follows.find_by(user: current_user).destroy if @profile.follows.find_by(user: current_user)
      render turbo_stream: turbo_stream.update("follow_profile_#{@profile.id}".to_sym, nil, partial:"shared/follows", locals: {profile: @profile, following: false})
  end
end