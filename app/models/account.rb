class Account < ApplicationRecord
  belongs_to :pricing_plan

  has_many :stylesheets, inverse_of: :account
  has_many :users, inverse_of: :account
  has_many :variables, through: :stylesheets

  has_one :credit_card
  has_one :slack_authentication

  accepts_nested_attributes_for :users


  before_validation :add_url_protocol

  protected

  def add_url_protocol
    unless self.site_url[/\Ahttp:\/\//] || self.site_url[/\Ahttps:\/\//]
      self.site_url = "http://#{self.site_url}"
    end
  end
end
