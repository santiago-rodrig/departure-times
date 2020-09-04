require 'rest-client'
require 'nokogiri'

class NextBusConsumer
  BASE_URL = 'http://webservices.nextbus.com/service/publicXMLFeed'
  AGENCY = 'sf-muni' # because it is just San Francisco

  def routes_list
    response = RestClient.get(
      BASE_URL,
      params: {command: 'reouteList', a: AGENCY}
    )

    parse_agencies_response(response.body)
  end

  def parse_routes_response(response_body)
    doc = Nokogiri::XML(response_body)
    json_result = []

    doc.css('route').each do |route|
      json_result << {
        'tag' => route['tag'],
        'title' => route['title']
      }
    end

    JSON.generate(json_result)
  end
end