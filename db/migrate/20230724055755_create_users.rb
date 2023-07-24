class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :type
      t.string :city
      t.string :location
      t.string :state
      t.string :address
      t.string :email

      t.timestamps
    end
  end
end
