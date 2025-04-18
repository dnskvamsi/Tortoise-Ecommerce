class TortoisesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :new]

    def new
        @tortoise = Tortoise.new
    end

    def edit
        @tortoise = Tortoise.find(params[:id])
    end

    def update
        @tortoise = Tortoise.find(params[:id])
        @tortoise.update(params_for_create)
        flash[:notice] = "Tortoise details updated successfully."
        respond_to do |format|
            format.turbo_stream { render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash') }
            format.html { redirect_to tortoise_path(@tortoise), notice: "Tortoise details updated successfully." }
        end
    end

    def show
        @tortoise = Tortoise.find(params[:id])
        @related_tortoises = Tortoise.where.not(id: @tortoise.id)
        rescue ActiveRecord::RecordNotFound
        redirect_to browse_listings_path, alert: "Tortoise not found."
    end

    def related
        current_tortoise_id = params[:current_tortoise_id]
        @related_tortoises = Tortoise.where.not(id: current_tortoise_id).limit(5)

        render partial: "related_tortoises", locals: { tortoises: @related_tortoises }
    end

    def create
        @tortoise = current_user.tortoises.create(params_for_create)
        redirect_to(root_path)
    end

    private

    def params_for_create
        params.require(:tortoise).permit(:name, :species, :gender, :shell_pattern, :shell_texture, :elite_design, :price, :quantity)
    end
end

