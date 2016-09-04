class UsersMailer < ApplicationMailer
  def new_user(user)
    mail(to: user.email, from: "notifications@mail.aphroditecss.com")
  end
end
