class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        @profile = Profile.find(params[:id])
        current_user.likes.create(profile: @profile) unless @profile.likes.find_by(user: current_user)
        render turbo_stream: turbo_stream.update("profile_#{@profile.id}".to_sym, nil, partial:"shared/likes", locals: {profile: @profile, liked: true})
    end

    def destroy
        @profile = Profile.find(params[:id])
        @profile.likes.find_by(user: current_user).destroy if @profile.likes.find_by(user: current_user)
        render turbo_stream: turbo_stream.update("profile_#{@profile.id}".to_sym, nil, partial: "shared/likes", locals: {profile: @profile, liked: false})
    end
end