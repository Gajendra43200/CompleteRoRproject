# frozen_string_literal: true

class ApiController < ActionController::API
  # Service to download ftp from the
  require 'jwt'
  include JsonWebToken
  before_action :authenticate_request, :check_customer
  def authenticate_request
	  begin
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      decoded = decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue StandardError
      render json: { error: 'Unauthorized User' }, status: 400
    end
  end

  def check_customer
    render json: { error: 'Not Allowed' } unless @current_user.user_type == 'Customer'
  end
end
