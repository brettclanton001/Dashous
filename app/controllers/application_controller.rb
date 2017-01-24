class ApplicationController < ActionController::Base
  before_action :persist_query
  before_action :enforce_domain
  protect_from_forgery with: :exception

  private

  def after_sign_in_path_for(resource)
    trade_requests_path
  end

  def persist_query
    @query = params[:query]
  end

  def enforce_domain
    unless request.host == Settings.default_url.host
      redirect_to "https://#{Settings.default_url.host}", status: 301
    end
  end
end
