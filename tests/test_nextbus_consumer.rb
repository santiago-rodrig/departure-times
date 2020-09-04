require './lib/nextbus_consumer'
require 'test/unit'

class NextBusConsumerTest < Test::Unit::TestCase
  def setup
    @consumer = NextBusConsumer.new
  end

  def test_it_parses_agencies_response
    response_body = '''
    <?xml version="1.0" encoding="utf-8" ?>
    <body copyright="All data copyright agencies listed below and NextBus Inc 2020.">
      <agency tag="jhu-apl" title="APL" regionTitle="Maryland"/>
      <agency tag="atlanta-sc" title="Atlanta Streetcar - Beta" regionTitle="Georgia"/>
      <agency tag="tl-bt" title="Brisbane-Transport" regionTitle="Australia"/>
    </body>
    '''

    result = @consumer.parse_agencies_response(response_body)

    assert_equal(
      {
        "jhu-apl" => {
          "title" => "APL",
          "regionTitle" => "Maryland"
        },
        "atlanta-sc" => {
          "title" => "Atlanta Streetcar - Beta",
          "regionTitle" => "Georgia"
        },
        "tl-bt" => {
          "title" => "Brisbane-Transport",
          "regionTitle" => "Australia"
        }
      },
      JSON.parse(result)
    )
  end
end
