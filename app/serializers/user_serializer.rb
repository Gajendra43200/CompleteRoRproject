class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_type, :email, :password_digest, :location, :user_profile
  def user_profile
    Rails.application.routes.url_helpers.rails_blob_path(object.user_profile, only_path: true) if object.user_profile.attached?
  end
end
