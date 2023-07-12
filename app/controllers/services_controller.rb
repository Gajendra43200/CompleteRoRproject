class ServicesController < ApplicationController
  #only:[:create,:show_all_customer,:destroy, :update,:show, :services_with_names]
  before_action :check_admin
  def create
    service = @current_user.services.new(service_params)
      check_render1(service,"Enter Valid Detail")if service.save
  end

  def update
    service = @current_user.services.find_by_id(params[:id])
    if service.blank?
      render json: { error:"Service Not Exits For Current Admin" }, status: :unprocessable_entity
    else
      service.update(service_params)
      render json: service, status: :ok
    end
  end

  def destroy
    service = @current_user.services.find_by_id(params[:id])
    if service.blank?
      render json: { error: "Service not exist " }
    elsif service.delete
      render json: { error: "Service Deleted " }
    else
      render json: { error: service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
      service = Service.find(params[:id])if Service.exists?(params[:id])
      check_render1(service,"Can't Find Service With This Given Id")
  end

  def services_with_names
    if services = Service.find_by(service_name: params[:service_name])
      render json: services, status: :ok
    else
      render json: { error: "Can't Find Service" }
    end
  end

  def index
    services = Service.all 
    render json: services, status: :ok
  end

  def show_all_customer
    customer = Customer.all
    # customer =  customer.select(:id, :name,:email,:city,:address,:location, :state, :location, :password_digest )
    render json: customer, status: :ok
  end

  private
  
  def service_params
    params.permit(:service_name, :status, :address, :city, :service_profile)
  end

  def check_admin
    if @current_user.type != "Admin"
      render json: {error: "Not Allowed"}
    end
  end
  def check_render1(service,message)
    if service.present?
      render json: service , status: :ok
    else
      render json: {message: "Please #{message}"}
    end
  end
end