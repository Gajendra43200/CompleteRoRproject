class RemoveForeignKeyConstraintFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :reviews, :services
  end
end
