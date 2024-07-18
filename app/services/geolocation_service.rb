class GeolocationService
  include HTTParty
  base_uri 'http://api.ipstack.com/'

  def initialize(api_key)
    @api_key = api_key
  end

  def get_location(ip_or_url)
    response = self.class.get("/#{ip_or_url}?access_key=#{@api_key}")
    if response.success?
      response.parsed_response
    else
      nil
    end
  end
end
