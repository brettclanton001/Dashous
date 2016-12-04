class ReviewService

  attr_reader \
    :errors,
    :message,
    :reviewing_user

  def initialize(reviewing_user, params)
    @reviewing_user = reviewing_user
    @params = params
    @errors = Array.new
  end

  def create
    validate
    return false if @errors.present?
    Review.create(
      reviewing_user: @reviewing_user,
      reviewed_user: @reviewed_user,
      offer: offer,
      tone: tone
    )
    true
  end

  def offer
    @offer ||= Offer.find(@params[:offer_id])
  end

  def message
    @errors.first or 'Review created successfully'
  end

  private

  def validate
    @errors << 'tone not present' and return unless tone.present?
    @errors << 'offer not found' and return unless offer.present?
    @errors << 'reviewing user not present' and return unless reviewing_user.present?
    @errors << 'reviewed user not present' and return unless reviewed_user.present?
  end

  def reviewed_user
    @reviewed_user ||= offer.user == reviewing_user ? offer.trade_request.user : offer.user
  end

  def tone
    @tone ||= @params[:tone]
  end
end
