class Users::TradeRequestsController < Users::BaseController
  before_action :set_trade_request, only: [:show, :edit, :update, :destroy]

  def index
    @trade_requests = current_user.trade_requests
    @expand = params[:expand].to_i
  end

  def new
    @trade_request = TradeRequest.new
  end

  def create
    @trade_request = current_user.trade_requests.build(trade_request_params)

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

  private

  def set_trade_request
    @trade_request = current_user.trade_requests.where(id: params[:id]).first
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
