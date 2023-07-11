class AddAdminAndCustomerToServices < ActiveRecord::Migration[7.0]
  def change
    add_reference :services, :admin
    # add_reference :services, :customer, null: false, foreign_key: true
  end
end
