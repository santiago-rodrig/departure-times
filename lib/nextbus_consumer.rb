require 'rest-client'
require 'nokogiri'
require 'cgi'

class NextBusConsumer
  BASE_URL = 'http://webservices.nextbus.com/service/publicXMLFeed'
  AGENCY = 'sf-muni' # because it is just San Francisco

  def routes_list
    response = RestClient.get(
      BASE_URL,
      params: {command: 'routeList', a: AGENCY}
    )

    parse_agencies_response(response.body)
  end

  def route_config(route_tag)
    response = RestClient.get(
      BASE_URL,
      params: {command: 'routeConfig', a: AGENCY, r: route_tag}
    )

    parse_route_data(response.body)
  end

  def parse_route_data(response_body)
    doc = Nokogiri::XML(response_body)

    json_result = {
      'stops' => [],
      'directions' => [],
      'paths' => []
    }

    doc.css('route > stop').each do |stop|
      json_result['stops'] << {
        'tag' => stop['tag'],
        'title' => stop['title'],
        'lat' => stop['lat'],
        'lon' => stop['lon'],
        'stopId' => stop['stopId']
      }
    end

    doc.css('route > direction').each do |direction|
      json_result['directions'] << {
        'tag' => direction['tag'],
        'title' => direction['title'],
        'name' => direction['name'],
        'stops' => []
      }

      last_direction = json_result['directions'].last

      direction.css('stop').each do |stop|
        last_direction['stops'] << {
          'tag' => stop['tag']
        }
      end
    end

    doc.css('route > path').each do |path|
      json_result['paths'] << {'points' => []}
      last_path = json_result['paths'].last

      path.css('point').each do |point|
        last_path['points'] << {
          'lat' => point['lat'],
          'lon' => point['lon']
        }
      end
    end

    JSON.generate(json_result)
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