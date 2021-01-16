class CreateTaxonomies < ActiveRecord::Migration[6.1]
  def change
    create_table :taxonomies do |t|
      t.text :name
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
