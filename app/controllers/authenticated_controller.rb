class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  layout "application"

  def current_account
    current_user.account
  end
end
