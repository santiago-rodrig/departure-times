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
end