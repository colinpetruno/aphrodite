class AlertsMailerPreview < ActionMailer::Preview
  def inquiry_alert_email
    inquiry = Inquiry.last
    AlertsMailer.inquiry_alert_email(inquiry)
  end
end
