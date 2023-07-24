class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :service_name, :location, :user_id, :status, :avg_rating, :service_profile
  def service_profile
    Rails.application.routes.url_helpers.rails_blob_path(object.service_profile, only_path: true) if object.service_profile.attached?
  end
end
