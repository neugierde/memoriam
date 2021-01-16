json.extract! taxon, :id, :ancestry, :taxonomy_id, :name, :created_at, :updated_at
json.url taxon_url(taxon, format: :json)
