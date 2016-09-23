class Variable < ApplicationRecord
  belongs_to :category
  belongs_to :stylesheet, inverse_of: :variables

  default_scope { order(:position) }

  enum variable_type: {
    color: 0,
    size: 1,
    variable: 2,
    sass: 3,
    blended_color: 4
  }

  def self.from(default_value)
    new(
      default: true,
      name: default_value.name,
      position: default_value.position,
      preview_value: default_value.value,
      value: default_value.value,
      category_id: default_value.category_id,
      variable_type: default_value.variable_type
    )
  end

  def input_type
    (variable_type || :string).to_sym
  end
end
