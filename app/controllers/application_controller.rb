class ApplicationController < ActionController::Base
  before_filter :persist_query
  protect_from_forgery with: :exception

  private

  def after_sign_in_path_for(resource)
    trade_requests_path
  end

  def persist_query
    @query = params[:query]
  end
end
