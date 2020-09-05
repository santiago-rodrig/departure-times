require 'sinatra'
require 'sinatra/json'
require './lib/nextbus_consumer'

CONSUMER = NextBusConsumer.new
API_VERSION = '/api/v1/'

get API_VERSION + 'routes' do
  json CONSUMER.routes_list
end

get API_VERSION + 'route_details' do
  route_tag = params[:route_tag]

  json CONSUMER.route_config(route_tag)
end