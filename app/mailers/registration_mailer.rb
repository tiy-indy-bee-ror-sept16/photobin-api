class RegistrationMailer < ApplicationMailer

  def new_user(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to PhotoBin!")
  end
end
