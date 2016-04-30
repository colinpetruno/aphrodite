class Application::CreditCardsController < AuthenticatedController
  def show
  end

  def edit
    @credit_card = current_account.credit_card || current_account.build_credit_card
  end

  def create
    @credit_card = current_account.build_credit_card(credit_card_params)

    if @credit_card.save
      redirect_to account_credit_card_path
    else
      render :new
    end
  end

  def update
    @credit_card= current_account.credit_card

    if @credit_card.update(credit_card_params)
      redirect_to account_credit_card_path
    else
      render :edit
    end
  end

  private

  def credit_card_params
    params.require(:credit_card).permit(:token)
  end
end
