class NotificationMailer < ApplicationMailer

  def offer_created(offer_id)
    offer = Offer.find(offer_id)
    @trade_request = offer.trade_request
    mail to: @trade_request.user.email
  end

  def offer_approved(offer_id)
    offer = Offer.find(offer_id)
    mail to: offer.user.email
  end
end
