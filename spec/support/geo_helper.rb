require 'webmock/rspec'

class GeoHelper
  class << self

    def define_stub(location, filename)
      WebMock.stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=#{location}&language=en&sensor=false").
        to_return(
          status: 200,
          body: File.open(Rails.root + 'spec' + 'fixtures' + "#{filename}.json").read,
          headers: {}
      )
    end
  end
end
