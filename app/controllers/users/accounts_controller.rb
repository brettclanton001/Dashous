class Users::AccountsController < Users::BaseController

  def update
    service = UserService.new(current_user)

    if service.update!(user_params)
      redirect_to request.referer,
        notice: 'Account Updated'
    end
  end

  private

  def set_section
    @section = :account
  end

  def user_params
    params.require(:user).permit(:currency)
  end
end
