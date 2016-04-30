class CreditCardUpdater
  include ActiveModel::Model

  attr_accessor :credit_card

  def update
    update_stripe_card
  end

  private

  def update_stripe_card
    customer.default_source = stripe_card.id
    customer.save

    stripe_card
  end

  def stripe_card
    @_stripe_card ||= begin
      customer.sources.create({ source: credit_card.token })
    rescue Stripe::InvalidRequestError => e
      handle_stripe_error(e)
    end
  end

  def handle_stripe_error(error)
    if error.message.include?("You cannot use a Stripe token more than once")
      customer.default_source = credit_card.stripe_id
      customer.save
      customer.sources.retrieve(credit_card.stripe_id)
    else
      raise error
    end
  end

  def customer
    @_customer ||= Stripe::Customer.retrieve(account.stripe_id)
  end

  def account
    credit_card.account
  end
end
