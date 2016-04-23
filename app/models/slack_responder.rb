class SlackResponder
  def initialize(input, team_id)
    @input = input
    @team_id = team_id
  end

  def as_json(_options={})
    send(parsed_command[:command].to_sym)
  end

  protected

  attr_reader :input, :team_id

  private

  def account
    begin
      SlackAuthentication.find_by!(team_id: team_id).account
    rescue ActiveRecord::RecordNotFound
      Account.new
    end
  end

  def parsed_command
    @_parsed_command ||= SlackCommandParser.new(command).parse
  end

  def variables
    stylesheet = account.stylesheets.find(parsed_command[:id])

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
    stylesheet = account.stylesheets.find(parsed_command[:id])

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
    variable = account.variables.find(parsed_command[:id])
    old_value = variable.preview_value

    if variable.update(preview_value: value)
      Resque.enqueue(BuildStylesheetJob, variable.stylesheet.id, true)
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
    split_input = input.split(" ")

    if split_input.length > 1
      split_input.last
    else
      nil
    end
  end
end
