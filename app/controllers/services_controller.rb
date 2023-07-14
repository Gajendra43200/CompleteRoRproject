# frozen_string_literal: true

class ServicesController < ApplicationController
  # Service to download ftp from the
  before_action :check_admin
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

  def services_with_names
    services = Service.find_by(service_name: params[:service_name])
    check_render1(services, 'Can not Find Service')
  end

  def index
    if params[:id].nil?
      services = Service.all
      check_render1(services, 'Not Find Services')
    else
      service = Service.find_by_id(params[:id])
      check_render1(service, "Can't Find Service With This Given Id")
    end
  end

  def show_all_customer
    customer = Customer.all
    check_render1(customer, 'Not Find Services')
  end

  private

  def service_params
    params.permit(:service_name, :status, :address, :city, :service_profile)
  end

  def check_admin
    render json: { error: 'Not Allowed' } unless @current_user.type == 'Admin'
  end

  def check_render1(service, message)
    if service.present?
      render json: service, status: :ok
    else
      render json: { message: "Please #{message}" }
    end
  end
end
