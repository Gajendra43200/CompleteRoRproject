class AaColumnCityServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services,:city, :string
  end
end
