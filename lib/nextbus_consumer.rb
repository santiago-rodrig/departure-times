require 'rest-client'
require 'nokogiri'

class NextBusConsumer
  BASE_URL = 'http://webservices.nextbus.com/service/publicXMLFeed'

  def agencies_list
    response = RestClient.get(BASE_URL, params: {command: 'agencyList'})
    parse_agencies_response(response.body)
  end

  def parse_agencies_response(response_body)
    doc = Nokogiri::XML(response_body)
    json_result = {}

    doc.css('agency').each do |agency|
      json_result[agency['tag']] = {
        'title' => agency['title'],
        'regionTitle' => agency['regionTitle']
      }
    end

    JSON.generate(json_result)
  end
end