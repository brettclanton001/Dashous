class Authentication::LoginService

  attr_reader :user, :password

  def initialize(params)
    @user = User.find_by_username params[:user][:username]
    @password = params[:user][:password]
  end

  def authenticated?
    return false unless user.present?
    return false unless password.present?
    return false unless password_correct?
    true
  end

  private

  def password_correct?
    stored_hash = ::BCrypt::Password.new(user.encrypted_password)
    provided_hash = ::BCrypt::Engine.hash_secret(password, stored_hash.salt)
    stored_hash.to_s == provided_hash.to_s
  end
end
