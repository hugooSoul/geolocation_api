require 'resolv'
require 'uri'

class GeolocationsController < ApplicationController
  before_action :set_geolocation, only: [:show, :destroy]

  def create
    service = GeolocationService.new(ENV['IPSTACK_API_KEY'])
    location_data = service.get_location(retrieve_url_ip(params['ip_or_url']))

    if location_data
      @geolocation = Geolocation.new(
        ip_address: location_data['ip'],
        url: params['ip_or_url'],
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

  rescue Resolv::ResolvError => e
    render json: { error: "Unable to fetch IP address: #{e}" }, status: :unprocessable_entity
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

  def retrieve_url_ip(ip_or_url)
    case ip_or_url
    when Resolv::IPv4::Regex
      ip_or_url
    when Resolv::IPv6::Regex
      ## NOTE: Not supported by IPStack
      ip_or_url
    else
      Resolv.getaddress(ip_or_url)
    end
  end
end
