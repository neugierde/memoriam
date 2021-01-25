class Taxon < ApplicationRecord
  include Ancestry

  def full_name!
    self.class.with_ancestry.find(id).full_name
  end
end
