class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.text :title
      t.text :extended_info
      t.string :tags, array: true, default: []

      t.references :archival_location, null: true, foreign_key: true
      t.references :taxon, null: true, foreign_key: true
      t.references :organization, null: true, foreign_key: true

      t.timestamps
    end
  end
end
