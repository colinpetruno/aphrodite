class Api::SlacksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_slack_request

  def create
    if [request.headers["ssl_check"], request.headers["SSL_CHECK"]].include?(1)
      render json: {}, status: :ok
    end
#     SlackAuthentication.find_by(team_id: params[:team_id])
    render json: SlackResponder.new(params[:text], params[:team_id])
    #stylesheets/index (done)
    #stylesheet/:id/variables (done)
    #stylesheet/:id/publish
    #variable/:id #some value (done)
    #help (done)

    # {
    # "token"=>"xxxxxxxxxxx",
    # "team_id"=>"T0ZC2JB9D",
    # "team_domain"=>"lunasfarms",
    # "channel_id"=>"D0ZC3KLCD",
    # "channel_name"=>"directmessage",
    # "user_id"=>"U0ZC3KL4D",
    # "user_name"=>"colinpetruno",
    # "command"=>"/aphrodite",
    # "text"=>"testmessage",
    # "response_url"=>"https://hooks.slack.com/commands/T0ZC2JB9D/33426010402/HwMiFPr3tnmTbxSEnnmX4lJ6",
    # "controller"=>"api/slacks",
    # "action"=>"create"}
  end


  private

  def verify_slack_request
    if params[:token] != Rails.application.secrets.slack_token
    # https://lunasfarms.slack.com/services/33411544167
    #  https://api.slack.com/applications/33410623319.35772666103
      render json: {
        text: "Ooops. We could not authenticate this request."
      } and return
    end
  end
end
