class CreateTaxons < ActiveRecord::Migration[6.1]
  def change
    create_table :taxons do |t|
      t.text :name
      t.text :extended_info

      t.references :parent, null: true, foreign_key: { to_table: t.name }

      t.timestamps
    end
  end
end
