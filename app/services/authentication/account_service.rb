class Authentication::AccountService

  def initialize(params)
    @user = User.new sign_up_params(params)
  end

  def create!
    @user.save
  end

  def errors
    @user.errors
  end

  private

  def sign_up_params(params)
    params.require(:user)
      .permit(:username, :email, :password, :password_confirmation, :terms_and_conditions)
      .merge(currency: 'usd')
  end
end
