class Users::TradeRequestsController < Users::BaseController
  before_action :set_trade_request, only: [:show, :edit, :update, :activate, :disable]

  def index
    @trade_requests = current_user.trade_requests.order('created_at DESC')
    @expand = params[:expand].to_i
  end

  def new
    @trade_request = TradeRequest.new
  end

  def create
    @trade_request = TradeRequestService.new(current_user).build(trade_request_params)

    if @trade_request.save
      redirect_to trade_requests_path, notice: 'Trade request was successfully created.'
    else
      render :new
    end
  end

  def update
    if @trade_request.update(trade_request_params)
      redirect_to trade_requests_path, notice: 'Trade request was successfully updated.'
    else
      render :edit
    end
  end

  def activate
    service = TradeRequestService.new(current_user, @trade_request)

    if service.activate
      redirect_to request.referer,
        notice: 'Trade Request Activated!'
    else
      redirect_to request.referer,
        alert: 'Trade Request not activated. You can only have two active trade requests at a time. You must disable another if you wish to activate this one.'
    end
  end

  def disable
    service = TradeRequestService.new(current_user, @trade_request)

    if service.disable
      redirect_to request.referer,
        notice: 'Trade Request Disabled.'
    end
  end

  private

  def set_trade_request
    trade_request_id = params[:id] || params[:trade_request_id]
    @trade_request = current_user.trade_requests.where(id: trade_request_id).first
    redirect_to trade_requests_path unless @trade_request.present?
  end

  def trade_request_params
    params.require(:trade_request).permit(
      :name,
      :description,
      :location,
      :kind,
      :currency,
      :profit
    )
  end

  def set_section
    @section = :trade_requests
  end
end
