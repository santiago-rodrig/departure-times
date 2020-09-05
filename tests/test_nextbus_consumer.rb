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
      JSON.parse(result)
    )
  end

  def test_it_parses_route_data
    response_body = File.open('./tests/test_data/input/route_test_data.xml').read
    result = @consumer.parse_route_data(response_body)
    parsed_json_result = JSON.parse(result)

    expected_parsed_json_result = JSON.parse(
      File.open('./tests/test_data/output/route_test_data.json').read
    )

    assert_equal expected_parsed_json_result, parsed_json_result
  end

  def test_it_parses_stop_id_prediction
    response_body = File.open('./tests/test_data/input/prediction_test_data.xml')
    result = @consumer.parse_prediction_data(response_body)

    assert_equal(
      JSON.parse(File.open('./tests/test_data/output/prediction_test_data.json').read),
      JSON.parse(result)
    )
  end
end
