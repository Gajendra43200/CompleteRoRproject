# frozen_string_literal: true

class Service < ApplicationRecord
  # Service to download ftp from the
  belongs_to :user
  has_many :reviews
  enum status: { open: 'open', close: 'close' }
  validates :service_name, :status, :location, :city, presence: true
  has_one_attached :service_profile
  def self.ransackable_attributes(auth_object = nil)
    ["city", "created_at", "id", "location", "service_name", "status", "updated_at", "user_id"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["reviews", "user"]
  end
end
