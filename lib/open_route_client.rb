require "open_route_client/version"
require "rest-client"
require "json"

module OpenRouteClient

  HEADERS = { :accept => 'application/json; charset=utf-8' }

  class << self

    def api_key
      @api_key ||= ENV.fetch('OPENROUTE_API_KEY') { '' }
    end

    def uri
      @uri ||= ENV.fetch('OPENROUTE_URI') { 'https://api.openrouteservice.org/' }
    end

    def remote_uri
      @remote_uri ||= ENV.fetch('REMOTE_URI') { uri }
    end

    def distance_between_addresses(start_address, destination_address, profile)
      start = locate(start_address)
      destination = locate(destination_address)
      distance(start, destination, profile)
    end

    def distance(start, destination, profile='driving-car')
      json_body = route(start, destination, profile)

      json_body["features"].first['properties']["summary"]["distance"]
    end

    def route(start, destination, profile='driving-car')

      start_coords = "#{start[:longitude]},#{start[:latitude]}"
      end_coords =  "#{destination[:longitude]},#{destination[:latitude]}"

      api_endpoint = uri + 'v2/directions/' + profile

      params = { params: {
        api_key: api_key,
        start: start_coords,
        end: end_coords
      } }

      puts params

      response = RestClient.get(api_endpoint, params)
      JSON.parse(response.body)
    end

    def locate(address)
      api_endpoint = remote_uri + 'geocode/search'
      params = { params: {
        api_key: api_key,
        text: address
      } }.merge(HEADERS)

      response = RestClient.get(api_endpoint, params)
      json_body = JSON.parse(response.body)

      coordinates = json_body["features"].first["geometry"]["coordinates"]

      {
        longitude: coordinates[0],
        latitude: coordinates[1]
      }
    end

  end
end
