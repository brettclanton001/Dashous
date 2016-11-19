class Users::BaseController < ApplicationController
  before_filter :require_user

  private

  def require_user
    head :unauthorized unless current_user.present?
  end
end
