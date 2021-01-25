# frozen_string_literal: true

# Replicates the features from https://github.com/stefankroes/ancestry
# using an array[bigint] column
module Ancestry
  extend ActiveSupport::Concern

  include ActiveSupport::Configurable

  included do
    config_accessor(:inherited_integer_columns) { [] }
    config_accessor(:inherited_text_columns) { [] }

    config_accessor(:full_name_separator) { ' > ' } # ⇨

    belongs_to :parent, class_name: name, optional: true
    has_many :children, class_name: name, inverse_of: :parent, foreign_key: :parent_id
  end

  module ClassMethods
    def with_ancestry
      nodes_inherited_base =
        (inherited_text_columns + inherited_integer_columns).map { "#{table_name}.#{_1} AS inherited_#{_1}," }.join(' ')

      nodes_inherited_text_coalesce =
        inherited_text_columns.map { "COALESCE(NULLIF(children.#{_1}, '') , parents.inherited_#{_1}),"}.join(' ')
      nodes_inherited_integer_coalesce =
        inherited_integer_columns.map { "COALESCE(children.#{_1}, parents.inherited_#{_1}),"}.join(' ')

      nodes_with_path_sql = <<~SQL.squish
        SELECT *,
               #{nodes_inherited_base}
               #{table_name}.name AS full_name,
               ARRAY[]::bigint[] AS ancestor_ids
        FROM #{table_name}
        WHERE #{table_name}.parent_id IS NULL

        UNION ALL

        SELECT children.*,
               #{nodes_inherited_text_coalesce}
               #{nodes_inherited_integer_coalesce}
               CONCAT_WS('#{full_name_separator}', parents.full_name, children.name),
               ARRAY_APPEND(parents.ancestor_ids, parents.id)
        FROM #{table_name} children
        INNER JOIN nodes_with_path parents ON children.parent_id = parents.id
      SQL

      with(:recursive, nodes_with_path: nodes_with_path_sql)
        .from("nodes_with_path AS #{table_name}")
    end

    def not_descendants_of(record)
      return with_ancestry unless record.persisted?

      with_ancestry.where.not('? = ANY (ancestor_ids)', record.id).where.not(id: record.id)
    end
  end
end
