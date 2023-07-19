# frozen_string_literal: true

class AdminSerializer < ActiveModel::Serializer
  # Service to download ftp from the
  attributes :id, :name, :email, :admin_profile
  def admin_profile
    Rails.application.routes.url_helpers.rails_blob_path(object.admin_profile, only_path: true) if object.admin_profile.attached?
  end
end
