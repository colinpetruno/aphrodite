class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  helper_method :current_account

  layout "application"

  def current_account
    current_user.account
  end
end
