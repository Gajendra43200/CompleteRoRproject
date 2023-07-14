# frozen_string_literal: true

class Admin < User
  # Service to download ftp from the
  has_many :services
  validates :name, presence: true
  validates :address, presence: true
  validates :location, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :password_digest, presence: true
  validates :email, presence: true, uniqueness: true
  has_one_attached :admin_profile
end
