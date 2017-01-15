class TradeRequestService

  def initialize(user, trade_request = nil)
    @user = user
    @trade_request = trade_request
  end

  def build(params)
    @trade_request = @user.trade_requests.build(params)
    @trade_request.active = limit_reached? ? false : true
    @trade_request.currency = 'usd'
    @trade_request
  end

  def activate
    return false if limit_reached?
    @trade_request.active = true
    @trade_request.save
  end

  def disable
    @trade_request.active = false
    @trade_request.save
  end

  private

  def limit_reached?
    @user.trade_requests.active.count >= 2
  end
end
