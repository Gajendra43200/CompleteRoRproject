class CustomersController < ApplicationController
  skip_before_action  :authenticate_request, only: [:create] 
  before_action :check_customer  , only: [:search_service]

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      render json: @customer, status: :created
    else
      render json: @customer.errors.full_messages, status: :unprocessable_entity
    end
  end

  def city
    if params[:city].present?
      services = Service.where(city: params[:city])
      check_render(services,"Enter Valid: city")
    else
      services = Service.all 
      check_render(services,"Service Not Exists")
    end
  end

  def search_by_location_services
    service= Service.where(address: @current_user.location)
    check_render(service,"Service not exit on this location")
  end

  def search_service
    services = Service.find_by(service_name: params[:service_name])
    check_render(services,"Enter Valid: service_name")
  end

  def sort_filter_by_rating
    if params[:rating].present?
      services = Review.where(rating: params[:rating])
      check_render(services,"Enter Valid Rating:1/5")
    elsif params[:status].present?
      services = Service.where(status: params[:status])
      check_render(services,"Enter Valid Status: open/closed")
    else
      services = Review.order(rating: :desc)
      check_render(services,"Services Not Orderd")
    end
  end
    
  private

  def check_render(service,message)
    if service.present?
      render json: service , status: :ok
    else
      render json: {message: "Please #{message}"}
    end
  end

  def check_customer
    if @current_user.type != "Customer"
      render json: {error: "Not Allowed"}
    end 
  end
  
  def customer_params
    params.permit(:name, :email, :password_digest, :address, :location, :city, :state, :customer_profile)
  end

end