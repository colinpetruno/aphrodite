class Application::StylesheetsController < AuthenticatedController
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
    # id = 7-stylesheet-name.css
    @stylesheet = Stylesheet.find(params[:id])

    render json: {}, status: :ok

    respond_to do |format|
      format.css do
        send_file(StylesheetResponder.
                    new(@stylesheet, params[:preview]).
                    path,
                  type: "text/css")
      end
    end
  end

  def publish
    @stylesheet = current_account.stylesheets.find(params[:id])
  end

  private

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
