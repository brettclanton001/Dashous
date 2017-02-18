class NotificationMailer < ApplicationMailer

  def offer_created(offer)
    @trade_request = offer.trade_request
    mail to: @trade_request.user.email
  end

  def offer_approved(offer)
    mail to: offer.user.email
  end
end
