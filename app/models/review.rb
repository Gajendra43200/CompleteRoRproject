class Review < ApplicationRecord
  belongs_to :customer, foreign_key: 'customer_id'
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :content, presence: true
end
