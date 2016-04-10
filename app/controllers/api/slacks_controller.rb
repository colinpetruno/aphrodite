class Api::SlacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    render json: SlackResponder.new(params[:text])
    #stylesheets/index (done)
    #stylesheet/:id/variables (done)
    #stylesheet/:id/publish
    #variable/:id #some value (done)
    #help (done)

    # {
    # "token"=>"8S4CA1s45ugCswkSmWTYkSDB",
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
end
