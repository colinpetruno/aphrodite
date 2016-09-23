class SourceFileCopier
  def initialize(stylesheet, preview=false)
    @preview = preview
    @stylesheet = stylesheet
  end

  def copy
    ensure_folder_exists
    system("cp '-rf' #{source_path} #{destination_path}")
  end

#  system("tr '\r' '\n' < #{temp_path} > #{temp_path}_2")
#  system("mv #{temp_path}_2 #{temp_path}")
  protected

  attr_reader :preview, :stylesheet

  private

  def ensure_folder_exists
    unless Dir.exist?(destination_path)
      FileUtils.mkdir_p(destination_path)
    end
  end

  def source_path
    Rails.root.join("lib", "frameworks", framework_folder, "*").to_s
  end

  def destination_path
    Rails.root.join("builds", stylesheet.id.to_s, build_folder).to_s
  end

  def framework_folder
    "#{stylesheet.framework}-#{stylesheet.version}"
  end

  def build_folder
    if preview
      "preview"
    else
      "published"
    end
  end
end
