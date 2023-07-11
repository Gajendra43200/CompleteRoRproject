class RenameNameToServiceNameInServices < ActiveRecord::Migration[7.0]
  def change
    rename_column :services, :name, :service_name
  end
end
