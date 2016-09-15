class StylesheetBuilder
  def self.build(stylesheet)
    new(stylesheet).build
  end

  def initialize(stylesheet)
    @stylesheet = stylesheet
  end

  def build
    build_default_values_and_save
  end

  protected

  attr_reader :stylesheet

  private

  def build_default_values_and_save
    DefaultVariable.
      where(
        framework: stylesheet.framework,
        version: stylesheet.version).
      map do |default_value|
        stylesheet.variables << Variable.from(default_value)
      end

    save
  end

  def save
    stylesheet.save
  end
end
