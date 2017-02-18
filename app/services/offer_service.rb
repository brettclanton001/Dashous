class OfferService

  attr_reader :offer

  def initialize(user, offer=nil)
    @user = user
    @offer = offer
  end

  def build(params)
    @offer = @user.offers.build params.merge(status: :pending)
    @action = 'offer_created'
  end

  def approve
    offer.status = :approved
    @action = 'offer_approved'
  end

  def decline
    offer.status = :declined
  end

  def save!
    if offer.save
      enqueue_notification
      true
    else
      false
    end
  end

  private

  def enqueue_notification
    if @action.present?
      NotificationJob.perform_later @action, offer.id
    end
  end
end
