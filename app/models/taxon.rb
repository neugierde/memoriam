class Taxon < ApplicationRecord
  include Ancestry

  belongs_to :taxonomy

  before_validation :inherit_taxonomy

  private

  def inherit_taxonomy
    self.taxonomy = parent.taxonomy if parent
  end
end
