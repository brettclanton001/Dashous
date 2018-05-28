class CountryService
  MAXMIND_DB = './vendor/GeoLite2-Country.mmdb'.freeze

  def initialize(ip)
    @ip = ip
  end

  def lookup
    {
      geoname_id: geoname_id,
      is_in_european_union: is_in_european_union?,
      iso_code: iso_code,
      name: country_name
    }
  end

  private

  def geoname_id
    return nil unless country_data
    country_data['geoname_id']
  end

  def is_in_european_union?
    return true unless country_data
    !!country_data['is_in_european_union']
  end

  def iso_code
    return nil unless country_data
    country_data['iso_code']
  end

  def country_name
    return nil unless country_data
    country_data['names']['en']
  end

  def country_data
    @country_data ||= maxmind.lookup(@ip)['registered_country']
  end

  def maxmind
    @maxmind ||= MaxMindDB.new(MAXMIND_DB)
  end
end
