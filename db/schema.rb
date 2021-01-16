# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_16_221349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organizations", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "taxonomies", force: :cascade do |t|
    t.text "name"
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_taxonomies_on_organization_id"
  end

  create_table "taxons", force: :cascade do |t|
    t.bigint "ancestry", array: true
    t.bigint "parent_id"
    t.bigint "taxonomy_id", null: false
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ancestry"], name: "index_taxons_on_ancestry"
    t.index ["parent_id"], name: "index_taxons_on_parent_id"
    t.index ["taxonomy_id"], name: "index_taxons_on_taxonomy_id"
  end

  add_foreign_key "taxonomies", "organizations"
  add_foreign_key "taxons", "taxonomies"
  add_foreign_key "taxons", "taxons", column: "parent_id"
end
