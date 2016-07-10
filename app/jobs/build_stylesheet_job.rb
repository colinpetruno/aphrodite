class BuildStylesheetJob
  @queue = :stylesheet_builds

  def self.perform(stylesheet_id, preview=false)
    puts "COMPILING STYLESHEET"
    @stylesheet = Stylesheet.find(stylesheet_id)
    StylesheetCompiler.new(@stylesheet, preview).compile

    puts "ABOUT TO BROADCAST"
    ActionCable.
      server.
      broadcast "stylesheet_#{stylesheet_id}", message: "compiled"
  end
end
