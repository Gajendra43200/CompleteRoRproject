# frozen_string_literal: true

class Service < ApplicationRecord
  # Service to download ftp from the
  validates :service_name, presence: true
  validates :status, presence: true
  validates :address, presence: true
  validates :city, presence: true
  belongs_to :admin, class_name: 'Admin', foreign_key: 'admin_id', optional: true
  has_many :reviews
  enum status: { open: 'open', close: 'close' }
  has_one_attached :service_profile
  def self.ransackable_attributes(auth_object = nil)
    ["address", "admin_id", "city", "created_at", "id", "service_name", "status", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["admin", "reviews", "service_profile_attachment", "service_profile_blob"]
  end
end
