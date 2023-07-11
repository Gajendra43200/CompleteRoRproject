class ServicesController < ApplicationController
  before_action :check_admin, only:[:create,:show_all_customer,:destroy, :update,:show, :services_with_names]
  
  def create
    service = @current_user.services.new(service_params)
    if service.save
      render json:  service, status: :created
    else
      render json: {error: @service.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    
    service = @current_user.services.find_by_id(params[:id])
    byebug
    if service.update(service_params)
      render json: service, status: :ok
    else
      render json: { error: service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    service = @current_user.services.find_by_id(params[:id])
    if service == nil
      render json: { error: "Service not exist " }
    elsif service.delete
      render json: { error: "Service Deleted " }
    else
      render json: { error: service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    if Service.exists?(params[:id])
      @service = Service.find(params[:id])
      render json: @service, status: :ok
    else
      render json: { error: "Can't Find Service With This Given Id" }
    end
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
    customer =  customer.select(:id, :name,:email,:city,:address)
    render json: customer, status: :ok
  end

  private
  def service_params
    params.permit(:service_name, :status, :address, :city)
  end

  def check_admin
    if @current_user.type != "Admin"
      render json: {error: "Not Allowed"}
    end
  end
end