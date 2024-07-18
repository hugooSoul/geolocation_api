class GeolocationsController < ApplicationController
  before_action :set_geolocation, only: [:show, :destroy]

  def create
    service = GeolocationService.new(ENV['IPSTACK_API_KEY'])
    location_data = service.get_location(params['ip_address'])

    if location_data
      @geolocation = Geolocation.new(
        ip_address: params[:ip_address],
        url: params[:url],
        city: location_data['city'],
        country: location_data['country_name'],
        country_code: location_data['country_code'],
        latitude: location_data['latitude'],
        longitude: location_data['longitude']
      )

      if @geolocation.save
        render json: @geolocation, status: :created
      else
        render json: @geolocation.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unable to fetch Geolocation data from IPStack' }, status: :unprocessable_entity
    end
  end

  def show
    render json: @geolocation
  end

  def destroy
    @geolocation.destroy
    head :no_content
  end

  private

  def set_geolocation
    @geolocation = Geolocation.find(params[:id])
  end
end
