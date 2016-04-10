class SlackResponder
  def initialize(input)
    @input = input
  end

  def as_json(_options={})
    send(parsed_command[:command].to_sym)
  end

  protected

  attr_reader :input

  private

  def parsed_command
    @_parsed_command ||= SlackCommandParser.new(command).parse
  end

  def variables
    stylesheet = Stylesheet.find(parsed_command[:id])

    if value.present?
      matching_variables = stylesheet.
        variables.
        where("name LIKE ?", "%#{value}%")
    else
      matching_variables = stylesheet.variables
    end

    result = ""

    if matching_variables.present?
      matching_variables.order(:name).in_groups_of(5) do |group|
        new_line = group.compact.map do |variable|
          next unless variable.present?
          "*##{variable.id}* #{variable.name}: #{variable.preview_value}"
        end.join(", ")
        result += "#{new_line}\n "
      end

      {
        text: result
      }
    else
      {
        text: "No variables found for #{value}"
      }
    end
  end

  def publish
  end

  def preview
    stylesheet = Stylesheet.find(parsed_command[:id])

    {
      text: "#{stylesheet.account.site_url}?preview-css=true&amp;stylesheetId=#{stylesheet.id}"
    }
  end

  def list_stylesheets
    {
      text: Stylesheet.all.map do |stylesheet|
        "*#{stylesheet.id}*: #{stylesheet.name} \n"
      end.join
    }
  end

  def update_variable
    variable = Variable.find(parsed_command[:id])
    old_value = variable.preview_value
    if variable.update(preview_value: value)
      { text: "*#{variable.id}* #{variable.name} updated from #{old_value} to #{variable.preview_value}" }
    else
      { text: "Ooops, we had an error updating your variable" }
    end
  end

  def help
    { text: I18n.t("api.slack.help") }
  end

  def command
    input.split(" ").first
  end

  def value
    input.split(" ").last
  end
end
