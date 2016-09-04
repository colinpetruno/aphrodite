class UsersMailerPreview < ActionMailer::Preview
  def new_user
    UsersMailer.new_user
  end
end
