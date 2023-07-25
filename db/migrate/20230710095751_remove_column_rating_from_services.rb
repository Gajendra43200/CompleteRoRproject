class RemoveColumnRatingFromServices < ActiveRecord::Migration[7.0]
  def change
    remove_column :services, :rating, :integer
  end
end
