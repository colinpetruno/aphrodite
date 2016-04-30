class CreditCard < ApplicationRecord
  belongs_to :account

  before_save :update_stripe_card

  private

  def update_stripe_card
    stripe_card = CreditCardUpdater.new(credit_card: self).update

    assign_attributes(stripe_id: stripe_card.id,
                      last_4: stripe_card.last4,
                      description: stripe_card.brand)

    stripe_card
  end
end
