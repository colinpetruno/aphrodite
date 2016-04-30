class Application::AccountsController < AuthenticatedController
  def edit
    @account = current_account
  end

  def update
    if current_account.update(account_params)
      redirect_to edit_account_path
    else
      render :edit
    end
  end

  private

  def account_params
    params.require(:account).permit(:site_url, :slack_publishing)
  end
end
