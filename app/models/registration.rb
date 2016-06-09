class Registration
  include ActiveModel::Model

  attr_accessor :account_name,
                :email,
                :password,
                :password_confirmation,
                :pricing_plan_id,
                :site_url

  validates :account_name,
            :email,
            :password,
            :password_confirmation,
            :pricing_plan_id,
            presence: true

  def register
    return false unless valid?

    save_registration
  end

  private

  def save_registration
    account.save
  end

  def payment_account
    @_payment_account ||= create_payment_account
  end

  def create_payment_account
    customer.
      subscriptions.
      create(plan: "individual", trial_end: trial_end)

    customer
  end

  def customer
    @_customer ||= Stripe::Customer.create(
      email: email
    )
  end

  def user
    account.users.first
  end

  def account
    @account ||= Account.new(
      name: account_name,
      pricing_plan_id: pricing_plan_id,
      stripe_id: payment_account.id,
      site_url: site_url,
      users_attributes: [{
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }])
  end

  def pricing_plan
    pricing_plan_id || PricingPlan.all.order(:price).first.id
  end

  def trial_end
    (DateTime.now().end_of_day + 7.days).to_i
  end
end
