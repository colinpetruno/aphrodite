class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: { member: 0, publisher: 1, owner: 2, developer: 3 }

  belongs_to :account, inverse_of: :users

  has_many :inquiries

  def can_view_resque?
    developer?
  end
end
