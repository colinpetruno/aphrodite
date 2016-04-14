class Variable < ApplicationRecord
  belongs_to :stylesheet, inverse_of: :variables
  belongs_to :category

  default_scope { order(:position) }
end
