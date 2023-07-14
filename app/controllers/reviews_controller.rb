# frozen_string_literal: true

class ReviewsController < ApplicationController
  # Service to download ftp from the
  before_action :authenticate_request
  def create
    @review = @current_user.reviews.new(review_params)
    if @review.save
      render json: @review
    else
      render json: { error: @review.errors.full_messages }
    end
  end

  private

  def review_params
    params.permit(:content, :rating, :service_id)
  end
end
