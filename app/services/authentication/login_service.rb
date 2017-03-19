class Authentication::LoginService

  def initialize(params)
    @user = User.find_by_username params[:user][:username]
    @password = params[:user][:password]
  end

  def create_session
  end

  def authenticated?
    return false unless @user.present?
    return false unless @password.present?
    true
  end
end
