class CustomersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :check_customer, except: [:create]

  # def create
  #   @customer = Customer.new(customer_params)
  #   if @customer.save
  #     render json: @customer, status: :created
  #   else
  #     render json: @customer.errors.full_messages, status: :unprocessable_entity
  #   end
  # end

  def create
    render json: (customer = Customer.new(customer_params)).save ? customer : customer.errors.full_messages, status: (customer.errors.empty? ? :created : :unprocessable_entity)
  end
  
  # def city
  #   if params[:city].present?
  #     services = Service.where(city: params[:city])
  #     check_render(services, "Enter Valid: city")
  #   else
  #     services = Service.all
  #     check_render(services, "Service Not Exists")
  #   end
  # end

  def all_services
    render json: (service = Service.all).present? ? service : 'Services Not Exists'
    # services = Service.all
    # render json: services
  end

  def city
    render json: (services = Service.where(city: params[:city])).present? ? services : 'Service Not Exists On This Location'
  end

  def search_by_location_services
    service = Service.where(address: @current_user.location)
    check_render(service, 'Service not exit on this location')
  end

  def search_service
    services = Service.find_by(service_name: params[:service_name])
    check_render(services, 'Enter Valid: service_name')
  end

  def sort_filter_by_rating
    if params[:rating].present?
      services = Review.where(rating: params[:rating])
      check_render(services, 'Enter Valid Rating:1/5')
    elsif params[:status].present?
      services = Service.where(status: params[:status])
      check_render(services, 'Enter Valid Status: open/close')
    else
      services = Review.order(rating: :desc)
      check_render(services, 'Services Not Orderd')
    end
  end

  private

  def check_render(service, message)
    if service.present?
      render json: service, status: :ok
    else
      render json: { message: "Please #{message}" }
    end
  end

  def check_customer
    render json: { error: 'Not Allowed' } unless @current_user.type == 'Customer'
  end
  
  def customer_params
    params.permit(:name, :email, :password_digest, :address, :location, :city, :state, :customer_profile)
  end
end
