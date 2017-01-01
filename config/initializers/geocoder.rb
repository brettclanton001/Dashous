Geocoder.configure(
  lookup: :google,
  use_https: true,
  cache: Redis.new,
  api_key: Settings.google_geocode.key
)
