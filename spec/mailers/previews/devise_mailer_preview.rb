class DeviseMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    user = User.first
    Devise::Mailer.reset_password_instructions(user, "insertRandomTokenHere")
  end
end
