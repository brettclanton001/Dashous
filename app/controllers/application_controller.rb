class ApplicationController < ActionController::Base
  before_action :persist_query
  before_action :init_gdpr
  protect_from_forgery with: :exception

  private

  def after_sign_in_path_for(resource)
    trade_requests_path
  end

  def persist_query
    @query = params[:query]
  end

  def init_gdpr
    @gdpr = GdprService.new(current_user, request.remote_ip)
  end
end
