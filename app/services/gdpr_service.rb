class GdprService

  def initialize(user, ip)
    @user = user
    @ip = ip
  end

  def cookies_allowed?
    return true if @user.present?
    !country[:is_in_european_union]
  end

  private

  def country
    CountryService.new(@ip).lookup
  end
end
