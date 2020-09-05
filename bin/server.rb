require 'sinatra'
require 'sinatra/json'
require './lib/nextbus_consumer'

CONSUMER = NextBusConsumer.new

get '/api/v1/routes' do
  json CONSUMER.routes_list
end