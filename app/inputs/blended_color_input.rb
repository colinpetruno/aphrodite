class BlendedColorInput < SimpleForm::Inputs::StringInput
  include ActionView::Helpers::FormOptionsHelper

  def input_html_classes
    # super.push("color-input")
    []
  end

  def additional_classes
    #@additional_classes ||= [required_class, readonly_class, disabled_class].compact
    #@additional_classes = ["testing"]
    ["form-inline blended-color-input"]
  end

  def input_type
    :string
  end

  def input
    # binding.pry if @stop != 12
    # object.preview_value
    template.content_tag(:div, class: "input-group") do
      template.concat blend_select_input
      template.concat @builder.text_field_tag(:blend_color, input_values.blend_color, class: "color-input form-control")
      template.concat @builder.text_field_tag(:blend_amount, input_values.blend_percentage, class: "form-control", type: "number", min: "0", max: "100")
      template.concat template.content_tag(:div, "%", class: "input-group-addon")
    end
  end

  private

  def blend_select_input
    @builder.select_tag(:blend_type,
                        options_for_select([
                          "darken",
                          "lighten",
                          "saturate",
                          "desaturate",
                          "adjust-hue",
                          "transparent"
    ], input_values.blend_type), class: "form-control")
  end

  def input_values
    @_blended_color_parser ||= BlendedColorParser.new(object)
  end

  # we need 3 things
  #
  # darken, lighten, tint, shade
  # base color
  # amount
end
