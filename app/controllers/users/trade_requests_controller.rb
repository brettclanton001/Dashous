class Users::TradeRequestsController < Users::BaseController
  before_action :set_trade_request, only: [:show, :edit, :update, :activate, :disable]

  def index
    @trade_requests = current_user.trade_requests
    @expand = params[:expand].to_i
  end

  def new
    @trade_request = TradeRequest.new
  end

  def create
    @trade_request = current_user.trade_requests.build(trade_request_params.merge(active: true))

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
    @trade_request.active = true

    if @trade_request.save
      redirect_to request.referer,
        notice: 'Trade Request Activated!'
    end
  end

  def disable
    @trade_request.active = false

    if @trade_request.save
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
      :location,
      :kind,
      :profit
    )
  end

  def set_section
    @section = :trade_requests
  end
end
