# frozen_string_literal: true

class ServicesController < ApiController
  # Service to download ftp from the
  before_action :check_admin, only:[:create, :update, :destroy]
  skip_before_action :check_customer, only:[:create, :update, :destroy]
  before_action :check_customer, only:[:index]
  def index
    if params[:service_name].present?
      services = Service.find_by(service_name: params[:service_name])
      check_render1(services, 'Can not Find Service')
    elsif params[:id].present?
      service = Service.find_by_id(params[:id])
      check_render1(service, "Can't Find Service With This Given Id")
    else
      services = Service.all
      check_render1(services, 'Not Find Services')
    end
  end

  def create
    service = @current_user.services.new(service_params)
    check_render1(service, 'Enter Valid Detail') if service.save
  end

  def update
    service = @current_user.services.find_by_id(params[:id])
    if service.nil?
      render json: { error: 'Service Not Exits For Current Admin' }
    else
      service.update(service_params)
      render json: service, status: :ok
    end
  end

  def destroy
    service = @current_user.services.find_by_id(params[:id])
    if service.nil?
      render json: { error: 'Service not exist For This Current User' }
    else
      service.delete
      render json: { error: 'Service Deleted' }
    end
  end

  private

  def service_params
    params.permit(:service_name, :status, :address, :city, :service_profile)
  end

  def check_admin
    render json: { error: 'Not Allowed' } unless @current_user.type == 'Admin'
  end

  def check_customer
      if @current_user.present?
      render json: { error: 'Not Allowed' } unless @current_user.type == 'Customer'
      end
  end

  def check_render1(service, message)
    if service.present?
      render json: service, status: :ok
    else
      render json: { message: "Please #{message}" }
    end
  end
end
