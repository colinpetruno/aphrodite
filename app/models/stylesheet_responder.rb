class StylesheetResponder
  def initialize(stylesheet, preview = false)
    @preview = preview
    @stylesheet = stylesheet
  end

  def path
    if file_exists?
      file_path
    else
      StylesheetCompiler.new(stylesheet, preview).compile
      file_path
    end
  end

  private

  attr_reader :preview, :stylesheet

  def file_exists?
    File.exist?(file_path)
  end

  def file_path
    "#{Rails.root}/builds/#{stylesheet.id}/#{version_path}/build_output.css"
  end

  def version_path
    if preview
      "preview"
    else
      "published"
    end
  end
end
