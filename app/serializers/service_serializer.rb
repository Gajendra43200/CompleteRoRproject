# frozen_string_literal: true

class ServiceSerializer < ActiveModel::Serializer
  # Service to download ftp from the
  attributes :id, :service_name, :address, :city, :service_profile, :status
  belongs_to :admin
  def service_profile
    Rails.application.routes.url_helpers.rails_blob_path(object.service_profile, only_path: true) if object.service_profile.attached?
  end
end
