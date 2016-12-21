class PublicController < ApplicationController
  def search
    @current_ip = request.remote_ip
    if @query
      @trade_requests = TradeRequest.near(@query, 5000).limit(20).decorate
    end
  end

  def trade_request
    @trade_request = TradeRequest.find(params[:trade_request_id]).decorate
  end

  def user_profile
    if profile_user = User.find_by_username(params[:username])
      @profile_user = profile_user.decorate
    else
      render :not_found
    end
  end
end
