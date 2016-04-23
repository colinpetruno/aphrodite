class Account < ApplicationRecord
  has_many :stylesheets, inverse_of: :account
  has_many :users, inverse_of: :account
  has_many :variables, through: :stylesheets
  has_one :slack_authentication

  accepts_nested_attributes_for :users
end
