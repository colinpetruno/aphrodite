class ColorInput < SimpleForm::Inputs::StringInput
  def input_html_classes
    super.push("color-input")
  end

  def additional_classes
    @additional_classes ||= [required_class, readonly_class, disabled_class].compact
  end

  def input_type
    :string
  end
end
