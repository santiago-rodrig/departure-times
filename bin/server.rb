require 'sinatra'
require 'sinatra/json'
require './lib/nextbus_consumer'

CONSUMER = NextBusConsumer.new
API_VERSION = '/api/v1/'

before do
  headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
  headers['Access-Control-Allow-Origin'] = '*'
  headers['Access-Control-Allow-Headers'] = 'accept, authorization, origin'
end

options '*' do
  response.headers['Allow'] = 'HEAD,GET,PUT,DELETE,OPTIONS,POST'
  response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
end

get API_VERSION + 'routes' do
  json CONSUMER.routes_list
end

get API_VERSION + 'route_details' do
  route_tag = params[:route_tag]

  json CONSUMER.route_config(route_tag)
end

get API_VERSION + 'prediction_by_id' do
  stop_id = params[:stop_id]

  json CONSUMER.predict_stop_departure_time_by_id(stop_id)
end

get API_VERSION + 'prediction_by_tag' do
  route_tag = params[:route_tag]
  stop_tag = params[:stop_tag]

  json CONSUMER.predict_stop_departure_time_by_tag(stop_tag, route_tag)
end