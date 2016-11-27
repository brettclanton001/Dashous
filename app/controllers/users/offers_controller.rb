class Users::OffersController < Users::BaseController

  def index
    @offers = current_user.offers
  end

  def create
    @offer = current_user.offers.build(offer_params.merge(status: :pending))

    if @offer.save
      redirect_to public_trade_request_path(@offer.trade_request_id), notice: 'Offer successfully created. Please wait for a reply.'
    end
  end

  private

  def offer_params
    params.require(:offer).permit(
      :trade_request_id
    )
  end
end
