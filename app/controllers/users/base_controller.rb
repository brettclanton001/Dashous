class Users::BaseController < ApplicationController
  before_filter :require_user

  private

  def require_user
    redirect_to root_path unless current_user.present?
  end
end
