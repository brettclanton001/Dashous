class Users::TradeRequests::OffersController < Users::BaseController
  before_action :get_offer

  def approve
    @offer.status = :approved

    if @offer.save
      redirect_to trade_requests_path(expand: @offer.trade_request_id),
        notice: 'Offer approved.'
    end
  end

  def decline
    @offer.status = :declined

    if @offer.save
      redirect_to trade_requests_path(expand: @offer.trade_request_id),
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
