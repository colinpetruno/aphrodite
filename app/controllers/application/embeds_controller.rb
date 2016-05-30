class Application::EmbedsController < AuthenticatedController
  def show
    @stylesheet = current_account.stylesheets.find(params[:stylesheet_id])
  end
end
