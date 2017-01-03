class PublicController < ApplicationController
  def search
    if params[:detect_location].present?
      @query = QueryService.new(request.location).query
    end
    if @query
      @trade_requests = TradeRequest.active.near(@query, 5000).limit(20).decorate
    end
  end

  def trade_request
    if trade_request = TradeRequest.active.find_by_slug(params[:trade_request_slug])
      @trade_request = trade_request.decorate
    else
      render :not_found
    end
  end

  def user_profile
    if profile_user = User.find_by_username(params[:username])
      @profile_user = profile_user.decorate
      @trade_requests = @profile_user.trade_requests.active.decorate
    else
      render :not_found
    end
  end
end
