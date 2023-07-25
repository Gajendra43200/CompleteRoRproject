class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address_line1
      t.string :address_line2
      t.string :locality
      t.string :city
      t.string :state
      t.string :type

      t.timestamps
    end
  end
end
