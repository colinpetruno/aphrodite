class Inquiry < ApplicationRecord
  def self.from_user(user=nil)
    if user.present?
      user.inquiries.build(email: user.email)
    else
      new
    end
  end
end
