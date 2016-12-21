class QueryService

  def initialize(location)
    @location = location
  end

  def query
    return human_location if location_found?
    @location.ip
  end

  private

  def location_found?
    @location.city.present?
  end

  def human_location
    "#{@location.city} #{@location.state}, #{@location.country}"
  end
end
