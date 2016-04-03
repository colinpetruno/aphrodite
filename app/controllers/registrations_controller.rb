class RegistrationsController < MarketingController
  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.register
      redirect_to stylesheets_path
    else
      render :new
    end
  end

  private

  def registration_params
    params.
      require(:registration).
      permit(
        :account_name,
        :email,
        :password,
        :password_confirmation,
        :site_url
      )
  end
end
