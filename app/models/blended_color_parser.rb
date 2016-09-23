class BlendedColorParser
  def initialize(variable)
    unless variable.blended_color?
      raise ArgumentError.new("Variable is not a blended color")
    end

    @variable = variable
  end

  def blend_type
    value.split("(").first
  end

  def blend_color
    color = value.split("(").last.split(",").first

    if color.include?("$")
      Variable.find_by(stylesheet_id: @variable.stylesheet_id, name: color).preview_value
    else
      color
    end
  end

  def blend_percentage
    value.split("(").last.split(",").last.to_d
  end

  private

  def value
    @variable.preview_value
  end
end
