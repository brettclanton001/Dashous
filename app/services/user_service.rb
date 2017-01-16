class UserService

  def initialize(user)
    @user = user
  end

  def update!(params)
    @user.update_attributes params
  end
end
