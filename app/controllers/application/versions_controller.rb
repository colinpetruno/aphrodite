class Application::VersionsController < AuthenticatedController
  def index
    @versions = Stylesheet::VERSIONS[params[:stylesheet_id].to_sym]
  end
end
