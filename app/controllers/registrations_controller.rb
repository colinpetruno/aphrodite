class RegistrationsController < MarketingController
  def new
    @registration = Registration.new(pricing_plan_id: pricing_plan_id)
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

  def pricing_plan_id
    params[:pricing_plan_id] || PricingPlan.all.order(:price).first.id
  end

  def registration_params
    params.
      require(:registration).
      permit(
        :account_name,
        :email,
        :password,
        :password_confirmation,
        :pricing_plan_id,
        :site_url
      )
  end
end
