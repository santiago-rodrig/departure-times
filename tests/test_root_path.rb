require './bin/server'
require 'test/unit'
require 'rack/test'

class RootPathTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_gets_root_route
    get '/'

    assert last_response.ok?
  end

  def test_it_receives_json
    get '/'

    assert_equal(
      {"result" => "Is working."},
      JSON.parse(last_response.body)
    )
  end
end