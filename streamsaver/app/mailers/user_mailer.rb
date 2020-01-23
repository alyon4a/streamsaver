class UserMailer < ApplicationMailer

    default from: 'streamsaver100@gmail.com'

    def notification_email(user, reminders)
        @user = user
        @reminders = reminders
        mail(to: @user.email, subject: 'Messages from Streamserver')
    end 
end
