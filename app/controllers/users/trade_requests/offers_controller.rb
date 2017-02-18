class Users::TradeRequests::OffersController < Users::BaseController
  before_action :get_offer

  def approve
    service = OfferService.new(current_user, @offer)
    service.approve

    if service.save!
      redirect_to request.referer,
        notice: 'Offer approved.'
    end
  end

  def decline
    service = OfferService.new(current_user, @offer)
    service.decline

    if service.save!
      redirect_to request.referer,
        notice: 'Offer declined.'
    end
  end

  private

  def get_offer
    @offer = current_user.trade_request_offers.find(params[:offer_id])
    if @offer.nil? or not @offer.pending?
      redirect_to trade_requests_path
    end
  end
end
