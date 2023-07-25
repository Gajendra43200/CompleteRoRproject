class AddColumnToServices < ActiveRecord::Migration[7.0]
  def change
    remove_column :services, :admin_id, :integer
    add_reference :services, :user, index: true
  end
end
