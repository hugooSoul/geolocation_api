class GeolocationSerializer
  include JSON::Serializer

  attributes :ip_address, :url, :city, :country, :country_code, :latitude, :longitude
end
