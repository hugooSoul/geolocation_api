class GeolocationService
  include HTTParty
  base_uri 'http://api.ipstack.com/'

  def initialize(api_key)
    @api_key = api_key
  end

  def get_location(ip_address)
    response = self.class.get("/#{ip_address}?access_key=#{@api_key}")
    if response.success?
      response.parsed_response
    else
      nil
    end
  end
end
