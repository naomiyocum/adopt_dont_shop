class AdminApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
    @pets = @app.pets

    if params[:approve]
      approved = ApplicationPet.find_me(@app.id, params[:approve])
      approved.pet_approved
    elsif params[:reject]
      rejected = ApplicationPet.find_me(@app.id, params[:reject])
      rejected.pet_rejected
    end
  end
end