# frozen_string_literal: true

class CustomerSerializer < ActiveModel::Serializer
  # Service to download ftp from the
  attributes :id, :name, :email, :address, :location, :city, :state, :customer_profile, :password_digest
  def customer_profile
    Rails.application.routes.url_helpers.rails_blob_path(object.customer_profile, only_path: true) if object.customer_profile.attached?
  end
end
