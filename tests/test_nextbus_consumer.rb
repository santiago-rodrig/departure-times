require './lib/nextbus_consumer'
require 'test/unit'

class NextBusConsumerTest < Test::Unit::TestCase
  def setup
    @consumer = NextBusConsumer.new
  end

  def test_it_parses_routes_response
    response_body = File.open('./tests/test_data/input/routes_test_data.xml').read
    result = @consumer.parse_routes_response(response_body)

    assert_equal(
      JSON.parse(File.open('./tests/test_data/output/routes_test_data.json').read),
      result
    )
  end

  def test_it_parses_route_data
    response_body = File.open('./tests/test_data/input/route_test_data.xml').read
    result = @consumer.parse_route_data(response_body)

    expected_parsed_json_result = JSON.parse(
      File.open('./tests/test_data/output/route_test_data.json').read
    )

    assert_equal expected_parsed_json_result, result
  end

  def test_it_parses_stop_id_prediction
    response_body = File.open('./tests/test_data/input/prediction_test_data.xml')
    result = @consumer.parse_predictions_data(response_body)

    assert_equal(
      JSON.parse(File.open('./tests/test_data/output/prediction_test_data.json').read),
      result
    )
  end
end
