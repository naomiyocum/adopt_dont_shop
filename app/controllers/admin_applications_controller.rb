class AdminApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
    @pets = @app.pets
    # binding.pry

    @app.to_approved if params[:approve]
    @app.to_rejected if params[:reject]
  end
end