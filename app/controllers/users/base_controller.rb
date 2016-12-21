class Users::BaseController < ApplicationController
  before_action :require_user
  before_action :set_section

  private

  def require_user
    redirect_to root_path unless current_user.present?
  end

  def set_section
    @section = nil
  end
end
