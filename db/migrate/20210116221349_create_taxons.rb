class CreateTaxons < ActiveRecord::Migration[6.1]
  def change
    create_table :taxons do |t|
      t.bigint :ancestry, array: true, index: true
      t.references :parent, foreign_key: { to_table: :taxons }, index: true
      t.references :taxonomy, null: false, foreign_key: true
      t.text :name

      t.timestamps
    end
  end
end
