class ApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
    @pets = Pet.all
    if params[:add_pet] != nil 
      @app.add_pet(params[:add_pet])
    end
  end

  def new
    @app = Application.new
  end

  def create
    @app = Application.new(app_params)
    if @app.save
      redirect_to "/applications/#{@app.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = @app.errors.full_messages.to_sentence
    end
  end

  def submit
    @app = Application.find(params[:id])
    @app.update(description: params[:why], status: 'Pending')
    redirect_to "/applications/#{@app.id}"
  end

private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end
