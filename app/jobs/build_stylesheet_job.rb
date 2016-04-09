class BuildStylesheetJob
  @queue = :stylesheet_builds

  def self.perform(stylesheet_id, preview=false)
    @stylesheet = Stylesheet.find(stylesheet_id)
    StylesheetCompiler.new(@stylesheet, preview).compile
    ActionCable.server.broadcast "stylesheet", message: "hello"
  end
end
