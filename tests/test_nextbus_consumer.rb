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

  def test_it_parses_route_data
    response_body = '''
    <?xml version="1.0" encoding="utf-8" ?>
    <body copyright="All data copyright San Francisco Muni 2020.">
      <route tag="MBUS" title="MBUS-M Ocean View Bus" color="006633" oppositeColor="ffffff" latMin="37.71315" latMax="37.7944099" lonMin="-122.4752999" lonMax="-122.39423">
        <stop tag="6501" title="Steuart St &amp; Market St" lat="37.7944099" lon="-122.39454" stopId="16501"/>
        <stop tag="5669" title="Market St &amp; Drumm St" lat="37.7934699" lon="-122.39618" stopId="15669"/>
        <stop tag="5639" title="Market St &amp; 2nd St" lat="37.7893499" lon="-122.40131" stopId="15639"/>
        <direction tag="MBUS_I_N00" title="Inbound to Embarcadero" name="Inbound" useForUI="true">
          <stop tag="6263" />
          <stop tag="7111" />
        </direction>
        <direction tag="MBUS_O_N00" title="Outbound to Balboa Park" name="Outbound" useForUI="true">
          <stop tag="6501" />
          <stop tag="5669" />
          <stop tag="5639" />
        </direction>
        <path>
          <point lat="37.74088" lon="-122.46572"/>
          <point lat="37.7409" lon="-122.46584"/>
          <point lat="37.73806" lon="-122.46898"/>
        </path>
        <path>
          <point lat="37.7752" lon="-122.41925"/>
          <point lat="37.76771" lon="-122.42878"/>
          <point lat="37.7642" lon="-122.43309"/>
          <point lat="37.76302" lon="-122.43498"/>
        </path>
      </route>
    </body>
    '''

    result = @consumer.parse_route_data(response_body)
    parsed_json_result = JSON.parse(result)
    expected_parsed_json_result = JSON.parse(
      File.open('./tests/data/route_data.json').read
    )

    assert_equal expected_parsed_json_result, parsed_json_result
  end
end
