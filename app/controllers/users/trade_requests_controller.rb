class Users::TradeRequestsController < Users::BaseController
  before_action :set_trade_request, only: [:show, :edit, :update, :destroy]

  def index
    @trade_requests = TradeRequest.all
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

  def destroy
    @trade_request.destroy
    redirect_to trade_requests_path, notice: 'Trade request was successfully destroyed.'
  end

  private

  def set_trade_request
    @trade_request = TradeRequest.find(params[:id])
  end

  def trade_request_params
    params.require(:trade_request).permit(
      :name,
      :location,
      :kind,
      :profit
    )
  end
end
