class Application::AccountsController < AuthenticatedController
  def edit
    @account = current_account
  end

  def update
    if current_account.update(account_params)
      redirect_to redirect_path
    else
      render :edit
    end
  end

  private

  def redirect_path
    if account_params[:pricing_plan_id].present?
      account_credit_card_path
    else
      edit_account_path
    end
  end

  def account_params
    params.
      require(:account).
      permit(:site_url, :slack_publishing, :pricing_plan_id)
  end
end
