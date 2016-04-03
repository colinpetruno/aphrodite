class Registration
  include ActiveModel::Model

  attr_accessor :account_name, :email, :password, :password_confirmation,
    :site_url

  validates :account_name, :email, :password, :password_confirmation,
    presence: true

  def register
    return false unless valid?

    save_registration
  end

  private

  def save_registration
    account.save
  end

  def account
    @account ||= Account.new(
      name: account_name,
      # site_url: site_url,
      users_attributes: [{
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }])
  end
end
