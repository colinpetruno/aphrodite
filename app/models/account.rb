class Account < ApplicationRecord
  has_many :stylesheets, inverse_of: :account
  has_many :users, inverse_of: :account

  accepts_nested_attributes_for :users
end
