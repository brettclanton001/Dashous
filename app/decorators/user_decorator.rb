class UserDecorator < Draper::Decorator
  delegate_all

  def total_trades
    object.offers.approved.count + object.trade_request_offers.approved.count
  end
end
