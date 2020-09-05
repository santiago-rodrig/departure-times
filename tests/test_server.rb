require './bin/server'
require 'test/unit'
require 'rack/test'

class RootPathTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_gets_routes_list
    get '/api/v1/routes'

    assert last_response.ok?
  end
end