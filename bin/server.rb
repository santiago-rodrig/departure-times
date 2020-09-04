require 'sinatra'
require 'sinatra/json'

get '/' do
  json result: 'Is working.'
end