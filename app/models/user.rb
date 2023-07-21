# frozen_string_literal: true

class User < ApplicationRecord
  # Service to download ftp from the
  has_many :services
  has_many :reviews, foreign_key: 'customer_id'
  validates :name, presence: true
  validates :address, presence: true
  validates :location, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :password_digest, presence: true
  validates :email, presence: true, uniqueness: true
  has_one_attached :user_profile
end
