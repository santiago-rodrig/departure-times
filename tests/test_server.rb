require './bin/server'
require 'test/unit'
require 'rack/test'

class RootPathTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  PATH_PREFIX = '/api/v1/'

  def test_it_gets_routes_list
    get PATH_PREFIX + 'routes'

    assert last_response.ok?
  end

  def test_it_gets_route_details
    get PATH_PREFIX + 'route_details', params: {route_tag: 'MBUS'}

    assert last_response.ok?
  end
end