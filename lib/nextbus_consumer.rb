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

    parse_routes_response(response.body)
  end

  def route_config(route_tag)
    response = RestClient.get(
      BASE_URL,
      params: {command: 'routeConfig', a: AGENCY, r: route_tag}
    )

    parse_route_data(response.body)
  end

  def predict_stop_departure_time_by_id(stop_id)
    response = RestClient.get(
      BASE_URL,
      params: {command: 'predictions', a: AGENCY, stopId: stop_id}
    )

    parse_predictions_data(response.body)
  end

  def predict_stop_departure_time_by_tag(stop_tag, route_tag)
    response = RestClient.get(
      BASE_URL,
      params: {command: 'predictions', a: AGENCY, s: stop_tag, r: route_tag}
    )

    parse_predictions_data_by_tag(response.body)
  end

  def parse_predictions_data(response_body)
    doc = Nokogiri::XML(response_body)
    json_result = []

    doc.css('predictions').each do |predictions|
      json_result << {
        'route' => {
          'stop' => {
            'title' => predictions['stopTitle'],
            'tag' => predictions['stopTag']
          },
          'tag' => predictions['routeTag'],
          'title' => predictions['routeTitle']
        }
      }

      last_predictions = json_result.last
      last_predictions['hasPrediction'] = predictions['dirTitleBecauseNoPredictions'] ? false : true

      if last_predictions['hasPrediction']
        last_predictions['directions'] = []

        predictions.css('direction').each do |direction|
          last_predictions['directions'] << {
            'title' => direction['title']
          }

          last_direction = last_predictions['directions'].last
          last_direction['predictions'] = []

          direction.css('prediction').each do |prediction|
            last_direction['predictions'] << {
              'epochTime' => prediction['epochTime'],
              'seconds' => prediction['seconds'],
              'minutes' => prediction['minutes'],
              'vehicle' => prediction['vehicle']
            }
          end
        end
      end
    end

    json_result
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

    json_result
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

    json_result
  end

  def parse_predictions_data_by_tag(response_body)
    doc = Nokogiri::XML(response_body)

    json_result = {
      'route' => {
        'tag' => '',
        'title' => '',
        'stop' => {
          'tag' => '',
          'title' => ''
        }
      }
    }

    doc.css('predictions').each do |predictions|
      json_result['route']['tag'] = predictions['routeTag']
      json_result['route']['title'] = predictions['routeTitle']
      json_result['route']['stop']['tag'] = predictions['stopTag']
      json_result['route']['stop']['title'] = predictions['stopTitle']
      has_prediction = predictions['dirTitleBecauseNoPredictions'] ? false : true
      json_result['hasPrediction'] = has_prediction

      if has_prediction
        json_result['directions'] = []

        predictions.css('direction').each do |direction|
          json_result['directions'] << {'title' => direction['title']}
          last_direction = json_result['directions'].last
          last_direction['predictions'] = []

          direction.css('prediction').each do |prediction|
            last_direction['predictions'] << {
              'epochTime' => prediction['epochTime'],
              'seconds' => prediction['seconds'],
              'minutes' => prediction['minutes'],
              'vehicle' => prediction['vehicle']
            }
          end
        end
      end
    end

    json_result
  end
end