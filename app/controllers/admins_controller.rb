class AdminsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create] 
  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      render json: @admin, status: :created
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end
  def index
    addmin = Admin.all
    render json: addmin, status: :ok
  end

  private
  def admin_params
    params.permit(:name, :email, :password_digest, :address, :location, :city, :state, :admin_profile)
  end
end
