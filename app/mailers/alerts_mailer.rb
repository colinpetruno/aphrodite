class AlertsMailer < ApplicationMailer
  def inquiry_alert_email(inquiry)
    @inquiry = inquiry

    mail(to: "colin@aphroditecss.com",
         from: "notifications@mail.aphroditecss.com",
         subject: "Customer Inquiry from #{@inquiry.email}")
  end
end
