class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :address, :location, :city, :state, :user_profile, :password_digest, :type
  def user_profile
    Rails.application.routes.url_helpers.rails_blob_path(object.user_profile, only_path: true) if object.user_profile.attached?
  end

end
