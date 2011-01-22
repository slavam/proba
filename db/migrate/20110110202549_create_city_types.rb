class CreateCityTypes < ActiveRecord::Migration
  def self.up
    create_table :city_types do |t|
      t.string :full_name, :null => false
      t.string :short_name, :null => false
    end
  end

  def self.down
    drop_table :city_types
  end
end
