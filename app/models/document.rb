class Document < ApplicationRecord
  belongs_to :archival_location, optional: true
  belongs_to :category, class_name: 'Taxon', optional: true, foreign_key: :taxon_id
  belongs_to :organization, optional: true

  has_one_attached :file
end
