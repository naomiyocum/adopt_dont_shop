class AdminApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
    @pets = @app.pets

    if params[:approve]
      approved = ApplicationPet.find_by(application_id: @app.id, pet_id: params[:approve])
      approved.pet_approved
    elsif params[:reject]
      rejected = ApplicationPet.find_by(application_id: @app.id, pet_id: params[:reject])
      rejected.pet_rejected
    end
  end

  # def update
  #   @app = Application.find(params[:id])
  #   if params[:approve]
  #     approved = ApplicationPet.find_by(application_id: @app.id, pet_id: params[:approve])
  #     approved = approved.pet_approved
  #   elsif params[:reject]
  #     rejected = ApplicationPet.find_by(application_id: @app.id, pet_id: params[:reject])
  #     rejected = rejected.pet_rejected
  #   end
  #   binding.pry
  #   redirect_to "/admin/applications/#{@app.id}"
  # end
end