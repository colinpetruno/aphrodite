class Marketing::InquiriesController < MarketingController
  def new
    @inquiry = Inquiry.from_user(current_user)
  end

  def create
    @inquiry = Inquiry.create(inquiry_params)

    if @inquiry.valid?
      AlertsMailer.inquiry_alert_email(@inquiry).deliver
    end
  end

  private

  def inquiry_params
    params.
      require(:inquiry).
      permit(:name, :email, :message).
      merge({ user_id: current_user.try(:id) })
  end
end
