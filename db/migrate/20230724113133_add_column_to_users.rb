class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :avg_rating, :integer
  end
end
