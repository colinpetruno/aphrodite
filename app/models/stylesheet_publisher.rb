class StylesheetPublisher
  def self.for(stylesheet)
    new(stylesheet)
  end

  def initialize(stylesheet)
    @stylesheet = stylesheet
  end

  def publish
    stylesheet.variables.update_all("value = preview_value")

    # Resque.enqueue(StylesheetPublisher, stylesheet.id)
  end

  protected

  attr_accessor :stylesheet
end
