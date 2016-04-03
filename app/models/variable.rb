class Variable < ApplicationRecord
  belongs_to :stylesheet, inverse_of: :variables
end
