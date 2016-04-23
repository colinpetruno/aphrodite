class SessionsController < AuthenticatedController

  def create
    if auth[:provider] == "slack"
      create_slack_authentication
    end

    redirect_to request.env['omniauth.origin'] || '/stylesheets'
  end

  def setup
    if params[:provider] == "slack"
      omniauth_strategy.options[:scope] = "incoming-webhook,commands"
      omniauth_strategy.options[:client_id] = "33410623319.35772666103"
    end

    render text: "Omniauth setup phase.", status: :ok
  end

  private

  def auth
    request.env["omniauth.auth"]
  end

  def slack_authentication
    if current_account.slack_authentication.present?
      current_account.slack_authentication
    else
      current_account.build_slack_authentication
    end
  end

  def create_slack_authentication
    slack_authentication.update(
      token: auth[:credentials][:token],
      team_id: auth[:info][:team_id]
    )
  end
end
