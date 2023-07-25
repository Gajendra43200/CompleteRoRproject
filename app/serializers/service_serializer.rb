# Service to download ftp from the

class ServiceSerializer < ActiveModel::Serializer
  # Service to download ftp from the
  attributes :id, :service_name, :location, :user_id, :status,:city, :avg_rating, :service_profile
  def service_profile
    Rails.application.routes.url_helpers.rails_blob_path(object.service_profile, only_path: true) if object.service_profile.attached?
  end
end
