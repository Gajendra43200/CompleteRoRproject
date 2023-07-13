class Service < ApplicationRecord
    validates :service_name, presence: true
    validates :status, presence: true
    validates :address, presence: true
    validates :city, presence: true
    belongs_to :admin, class_name: 'Admin', foreign_key: 'admin_id', optional: true
    has_many :reviews
    enum status:  { open: "open", close: "close" }
    has_one_attached :service_profile
end


