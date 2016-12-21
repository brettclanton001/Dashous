class Users::AccountController < Users::BaseController

  private

  def set_section
    @section = :account
  end
end
