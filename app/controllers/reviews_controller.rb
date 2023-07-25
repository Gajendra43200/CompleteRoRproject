# frozen_string_literal: true

class ReviewsController < ApiController
  # Service to download ftp from the
  before_action :authenticate_request
  before_action :check_customer
  def index
    if params[:avg_rating].present?
      services = Service.where(avg_rating: params[:avg_rating])
      check_render(services, 'Enter Valid Rating:1/5 / Or Service Not Exists For This Rating')
    elsif params[:status].present?
      services = Service.where(status: params[:status])
      check_render(services, 'Enter Valid Status: open/close')
    else
      services = Service.order(avg_rating: :desc)
      check_render(services, 'Services Not Orderd')
    end
  end

  def create
    @review = @current_user.reviews.new(review_params)
    if @review.save
      render json: @review
    else
      render json: { error: @review.errors.full_messages }
    end
  end

  def update
    review = @current_user.reviews.find_by_id(params[:id])
    if review.nil?
      render json: { error: 'Review Not Exists For Current Customer' }
    else
      review.update(review_params)
      render json: review, status: :ok
    end
  end

  def destroy
    review = @current_user.reviews.find_by_id(params[:id])
    if review.present?
      review.delete
      render json: { message: 'current user review deleted' }
    else
      render json: { error: 'review  not exists' }, status: :unprocessable_entity
    end
  end

  def location_service_name
    if  params[:service_name].present?
      services = Service.where("service_name like ?" ,"%#{params[:service_name]}%")
      check_render(services, 'Enter Valid: service_name/service not exists')
    elsif params[:city].present?
      services = Service.where("city like ?" ,"%#{params[:city]}%")
      check_render(services, 'Enter Valid: city/ On This City Service Not Exists')
    else
      service = Service.where(location: @current_user.location)
      byebug
      if service.present?
        check_render(service, 'Service not exit on this location')
      else
        services = Service.all
        check_render(services, 'Service Not Exists')
      end
    end
  end

  private

  def review_params
    params.permit(:content, :rating, :service_id)
  end

  def check_render(service, message)
    if service.present?
      render json: service, status: :ok
    else
      render json: { message: "message/error: #{message}" }
    end
  end
end
