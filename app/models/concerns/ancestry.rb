# Replicates the features from https://github.com/stefankroes/ancestry
# using an array[bigint] column
module Ancestry
  extend ActiveSupport::Concern

  included do
    belongs_to :parent, class_name: name, optional: true
    has_many :children, class_name: name, inverse_of: :parent
    before_save :set_ancestry
  end

  def has_parent? = parent_id.present? # rubocop:disable Naming/PredicateName

  def parent_of?(other) = other.parent == self

  def root = ancestry.present? ? self.class.find(ancestry.first) : self

  def root_id = ancestry.present? ? ancestry.first : id

  def is_root? = ancestry.blank? # rubocop:disable Naming/PredicateName

  def root_of?(other) = other.is_root? ? other == self : other.ancestry.first == id

  def ancestors = self.class.where(id: ancestry).sort_by { ancestry.index _1 }

  def ancestor_ids = ancestry

  # ??
  def ancestors? = nil

  def ancestor_of?(other) = other.ancestry.include?(id)

  def child_ids = children.loaded? ? children.map(&:id) : children.pluck(:id)

  def has_children? = children.loaded? ? children.present? : children.exist?

  def child_of?(other) = other == parent

  def descendants = self.class.where("ancestry[#{1 + ancestry.size}] = ?", id)

  def descendant_ids = descendants.pluck(:id)

  def descendant_of?(other) = ancestry.include?(other.id)

  private

  def set_ancestry
    self.ancestry = parent.present? ? [*parent.ancestry, parent.id] : []
  end
end
