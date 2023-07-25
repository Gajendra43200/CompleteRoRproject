class AddCustomerToReviews < ActiveRecord::Migration[7.0]
  # def change
  #   add_reference :reviews, :customer, null: false, foreign_key: true
  # end
  # def up
  #   unless column_exists?(:reviews, :customer_id)
  #     add_reference :reviews, :customer, foreign_key: true
  #   end
  # end

  # def down
  #   if column_exists?(:reviews, :customer_id)
  #     remove_reference :reviews, :customer, foreign_key: true
  #   end
  # end
end
