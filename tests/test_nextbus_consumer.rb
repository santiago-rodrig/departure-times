require './lib/nextbus_consumer'
require 'test/unit'

class NextBusConsumerTest < Test::Unit::TestCase
  def setup
    @consumer = NextBusConsumer.new
  end

  def test_it_parses_routes_response
    response_body = '''
    <?xml version="1.0" encoding="utf-8" ?>
    <body copyright="All data copyright San Francisco Muni 2020.">
      <route tag="JBUS" title="JBUS-J Church Bus"/>
      <route tag="KBUS" title="KBUS-K Ingleside Bus"/>
    </body>
    '''

    result = @consumer.parse_routes_response(response_body)

    assert_equal(
      [
        {'tag' => 'JBUS', 'title' => 'JBUS-J Church Bus'},
        {'tag' => 'KBUS', 'title' => 'KBUS-K Ingleside Bus'}
      ],
      JSON.parse(result)
    )
  end
end
