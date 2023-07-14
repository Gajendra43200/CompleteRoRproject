# frozen_string_literal: true

class AdminsController < ApplicationController
  # Service to download ftp from the
  skip_before_action :authenticate_request, only: [:create]
  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      render json: @admin, status: :created
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  private

  def admin_params
    params.permit(:name, :email, :password_digest, :address, :location, :city, :state, :admin_profile)
  end
end
