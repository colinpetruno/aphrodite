class Application::StylesheetsController < AuthenticatedController
  after_action :set_cache_headers, only: [:show]
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @stylesheets = current_account.stylesheets.order(:name)
  end

  def new
    @stylesheet = current_account.stylesheets.build
  end

  def create
    @stylesheet = current_account.stylesheets.build(stylesheet_params)

    if @stylesheet.valid?
      StylesheetBuilder.build(@stylesheet)
      redirect_to edit_stylesheet_path(@stylesheet)
    else
      render :new
    end
  end

  def edit
    @stylesheet = current_account.stylesheets.find(params[:id])
  end

  def update
    @stylesheet = current_account.stylesheets.find(params[:id])

    @stylesheet.update(stylesheet_params)
    Resque.enqueue(BuildStylesheetJob, @stylesheet.id, true)
  end

  def show
    @stylesheet = Stylesheet.find(params[:id])

    render json: {}, status: :ok

    respond_to do |format|
      format.css do
        send_file(StylesheetResponder.
                    new(@stylesheet, preview?).
                    path,
                  filename: @stylesheet.filename(preview: preview?),
                  type: "text/css")
      end
    end
  end

  def destroy
    stylesheet = Stylesheet.find(params[:id])

    if stylesheet.destroy
      redirect_to stylesheets_path
    else
      redirect_to stylesheet_path, error: "Something went wrong"
    end
  end

  def publish
    @stylesheet = current_account.stylesheets.find(params[:id])

    publisher = StylesheetPublisher.for(@stylesheet)

    if publisher.publish
      redirect_to edit_stylesheet_path(@stylesheet)
    else

    end
  end

  private

  def preview?
    params[:preview] || params[:id].to_s.exclude?(".min.css")
  end

  def set_cache_headers
    unless preview?
      response.headers["Cache-Control"] = "public, max-age=31536000"
      remove_keys = %w(X-Runtime Server X-XSS-Protection X-Runtime X-Request-Id X-Frame-Options X-Content-Type-Options Content-Transfer-Encoding Set-Cookie)
      response.headers.delete_if{|key| remove_keys.include? key}
    end
  end

  def stylesheet_params
    params.
      require(:stylesheet).
      permit(:framework,
             :name,
             :version,
             variables_attributes: [:id, :name, :preview_value]
            )
  end
end
