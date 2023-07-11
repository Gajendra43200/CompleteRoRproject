class CustomersController < ApplicationController
  skip_before_action  :authenticate_request, only: [:create] 
  before_action :check_customer  , only: [:search_service,:filter_by_status ]

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: customer, status: :created
    else
      render json: customer.errors.full_messages, status: :unprocessable_entity
    end
  end

  def index
    if params[:city].present?
      services = Service.where(city: params[:city])
      render json: services, status: :ok
    else
      services = Service.all 
      render json: services, status: :ok
    end
  end

  def search_by_location_services
    byebug
    service= Service.where(address: @current_user.location)
    if service.exists?
      render json: service , status: :ok
    else
      render json: {message:"Service not exit on this location"}
    end
      

  end


  def search_service
    services = Service.find_by(service_name: params[:service_name])
    render json: services, status: :ok
  end

  def sort_by_ratings
    services = Review.order(rating: :desc)
    render json: services, status: :ok
  end

  def filter_by_ratings
    services = Review.where(rating: params[:rating])
    render json: services, status: :ok
  end

  def filter_by_status
    services = Service.where(status: params[:status])
    render json: services, status: :ok
  end
    
  private

  def check_customer
    if @current_user.type != "Customer"
      render json: {error: "Not Allowed"}
    end
  end

  def customer_params
    params.permit(:name, :email, :password_digest, :address, :location, :city, :state)
  end
end
