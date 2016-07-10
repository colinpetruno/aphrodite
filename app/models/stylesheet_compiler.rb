class StylesheetCompiler
  ROOT_FILE = {
    bootstrap: "bootstrap.scss"
  }

  def initialize(stylesheet, preview=false)
    @preview = preview
    @stylesheet = stylesheet
  end

  def compile
    copy_source_files
    build_variable_file
    compile_stylesheet
    invalidate_cache if Rails.env.production?
  end

  protected

  attr_reader :preview, :stylesheet

  private

  def invalidate_cache
    CacheInvalidator.invalidate(stylesheet, preview)
  end

  def copy_source_files
    SourceFileCopier.new(stylesheet, preview).copy
  end

  def build_variable_file
    VariableFileWriter.new(stylesheet, preview).write
  end

  def compile_stylesheet
    if Rails.env.production?
      system("/usr/local/sassc/bin/sassc #{source_file} > #{destination_file}")
    else
      system("/Users/Colin/Projects/sassc/bin/sassc #{source_file} > #{destination_file}")
    end
  end

  def root_file
    ROOT_FILE[stylesheet.framework.to_sym]
  end

  def source_file
    Rails.root.join("builds", stylesheet.id.to_s, build_folder, root_file).to_s
  end

  def destination_file
    Rails.
      root.
      join("builds", stylesheet.id.to_s, build_folder, "build_output.css").to_s
  end

  def build_folder
    if preview
      "preview"
    else
      "published"
    end
  end
end
