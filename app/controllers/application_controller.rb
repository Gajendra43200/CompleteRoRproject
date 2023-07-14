# frozen_string_literal: true

class ApplicationController < ActionController::API
  # Service to download ftp from the
  require 'jwt'
  include JsonWebToken
  before_action :authenticate_request

  private

  def authenticate_request
	  begin
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      decoded = decode(header)
      @current_user = User.find_by_id(decoded[:user_id])
    rescue StandardError
      render json: { error: 'Unauthorized User' }, status: 400
    end
  end
end