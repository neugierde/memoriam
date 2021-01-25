class CreateArchivalLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :archival_locations do |t|
      t.text :name
      t.text :extended_info
      t.text :address_code

      t.references :parent, null: true, foreign_key: { to_table: t.name }
      t.references :organization, null: true, foreign_key: true

      t.timestamps
    end
  end
end
