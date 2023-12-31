# frozen_string_literal: true

class AuthenticationController < ApiController
  # frozen_string_literal: true
  skip_before_action :authenticate_request, :check_customer
  def login
    @user = User.find_by_email(params[:email])
    if @user.nil?
      render json: { error: 'enter valid email' }
    elsif @user.password_digest == params[:password]
      token = jwt_encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
