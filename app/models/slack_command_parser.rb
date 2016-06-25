class SlackCommandParser
  def initialize(command)
    @command = command.downcase
  end

  def parse
    case
    when command.match(/stylesheets\/\d+\/variables/)
      { command: "variables", id: command_integer }
    when command.match(/stylesheets\/\d+\/publish/)
      { command: "publish", id: command_integer }
    when command.match(/stylesheets\/\d+\/preview/)
      { command: "preview", id: command_integer }
    when command.match(/stylesheets\/index/)
      { command: "list_stylesheets" }
    when command.match(/variables\/\d+/)
      { command: "update_variable", id: command_integer }
    when command.match(/help/)
      { command: "help" }
    else
      "error"
    end
  end

  protected

  attr_reader :command

  private

  def command_integer
    command.split("/").second.to_i
  end
end
