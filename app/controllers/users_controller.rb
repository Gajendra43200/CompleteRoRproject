# frozen_string_literal: true

class UsersController < ApiController
  # Service to download ftp from the
  include JsonWebToken
  skip_before_action :authenticate_request, only: [:create]
  skip_before_action :check_customer
  def create
    user = User.new(user_params)
    if user.save
      token = jwt_encode(user_id: user.id)
      render json: { user: user,token: token }, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def show
    if params[:id].present?
      user = User.find_by(id: params[:id])
      render json: user, status: :ok
    else
      user = User.all
      render json: user , status: :ok
    end
  end

  def update
    if @current_user.update(user_params)
      render json: { current_user: @current_user }, status: :ok
    else
      render json: { error: 'user not exits' }, status: :unprocessable_entity
    end 
  end

  private

  def user_params
    params.permit(:name, :email, :password_digest, :address, :location, :city, :state, :user_profile, :type)
  end

  
end
