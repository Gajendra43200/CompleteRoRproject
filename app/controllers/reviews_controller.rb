class ReviewsController < ApplicationController
  before_action :authenticate_request
  
  def create
    @review =@current_user.reviews.new(review_params)
    if @review.save
      render json:@review
    else
      render json: {error: @review.errors.full_messages}
    end
  end
  private
  def review_params
    params.permit(:content,:rating,:service_id)
  end
end
  



















  # @service = Service.find(params[:service_id])
      # @review = @service.reviews.new(review_params.merge(user_id: current_user.id))
  
      # if @review.save
      #   render json: @review, status: :created
      # else
      #   render json: @review.errors, status: :unprocessable_entity
      # end
      # byebug
      # @service=Service.find_by_id(params[:id])