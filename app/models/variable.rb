class Variable < ApplicationRecord
  belongs_to :category
  belongs_to :stylesheet, inverse_of: :variables

  default_scope { order(:position) }
end
