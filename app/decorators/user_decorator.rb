class UserDecorator < Draper::Decorator
  delegate_all

  def total_trades
    object.offers.approved.count + object.trade_request_offers.approved.count
  end

  def reputation
    reviews = object.incoming_reviews
    total = reviews.count
    positive = reviews.positive.count
    percentage = total.zero? ? 0 : (positive * 100 / total).floor
    "#{percentage}% positive reviews (#{total} reviews)"
  end
end
