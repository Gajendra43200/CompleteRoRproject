  # Service to download ftp from the

class User < ApplicationRecord
  # Service to download ftp from the
  has_many :services
  has_many :reviews
  validates :name, :address, :location, :city, :state, :password_digest, :email, presence: true
  validates :email, uniqueness: true
  has_one_attached :user_profile
  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "created_at", "email", "id", "location", "name", "password_digest", "state", "user_type", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["reviews", "services"]
  end
end
