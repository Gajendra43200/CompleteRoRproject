class RenameColumnInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :locality, :location
  end
end
