class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user)
      .permit(:username, :email, :password, :password_confirmation, :terms_and_conditions)
      .merge(currency: 'usd')
  end
end
