class RenameAddressLine1ToAddressInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :address_line1, :address
  end
end
