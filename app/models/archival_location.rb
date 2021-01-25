class ArchivalLocation < ApplicationRecord
  include Ancestry

  self.inherited_integer_columns = %i[organization_id]
  self.inherited_text_columns = %i[address_code]

  belongs_to :organization, optional: true
  belongs_to :inherited_organization, class_name: 'Organization', optional: true

  def full_name!
    self.class.with_ancestry.find(id).full_name
  end
end
