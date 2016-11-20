class PublicController < ApplicationController
  def search
    if @query
      @trade_requests = TradeRequest.near(@query, 5000).limit(20)
    end
  end
end
