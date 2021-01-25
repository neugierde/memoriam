class Document
  class Filter
    include ActiveModel::Model
    include ActiveModel::Attributes

    def self.model_name = ActiveModel::Name.new(self, Document)

    attribute :format
    attribute :category
    attribute :organization
    attribute :location

    def self.formats
      ActiveStorage::Blob.distinct.pluck(:content_type)
    end

    def self.locations
      ArchivalLocation.with_ancestry.pluck(:full_name, :id)
    end

    def self.organizations
      Organization.with_ancestry.pluck(:full_name, :id)
    end

    def self.categories
      Taxon.with_ancestry.pluck(:full_name, :id)
    end

    def call(scope)
      if format.present?
        scope = scope.joins(file_attachment: :blob)
                     .merge(ActiveStorage::Blob.where(content_type: format))
      end

      scope = scope.where(organization_id: organization) if organization.present?
      scope = scope.where(archival_location_id: location) if location.present?
      scope = scope.where(taxon_id: category) if category.present?

      scope
    end
  end
end
