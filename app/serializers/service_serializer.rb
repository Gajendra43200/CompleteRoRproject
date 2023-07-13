class ServiceSerializer < ActiveModel::Serializer
  attributes :id ,:service_name, :address, :city, :service_profile, :status
  def service_profile
    Rails.application.routes.url_helpers.rails_blob_path(object.service_profile, only_path: true)if object.service_profile.attached?
    # Rails.application.routes.url_helpers.rails_blob_path(object.profile_picture, only_path: true).service_profile.filename
  end
end
