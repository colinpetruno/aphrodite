class VariableFileWriter
  def self.for(stylesheet)
    new(stylesheet).write
  end

  def self.preview_for(stylesheet)
    new(stylesheet, true).write
  end

  def initialize(stylesheet, preview = false)
    @preview = preview
    @stylesheet = stylesheet
  end

  def write
    file = File.new(file_path, "w")
    file.puts(file_contents)
    file.close
  end

  private

  attr_reader :preview, :stylesheet

  def file_path
    Rails.root.join("builds", stylesheet.id.to_s, version_path,"_custom.scss")
  end

  def version_path
    if preview
      "preview"
    else
      "published"
    end
  end

  def value_method
    if preview
      :preview_value
    else
      :value
    end
  end

  def file_contents
    variables.map do |variable|
      "#{variable.name}: #{variable.send(value_method)};"
    end.
    join("\n")
  end

  def variables
    stylesheet.variables.order(:position)
  end
end
