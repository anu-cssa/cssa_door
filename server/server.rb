require 'sinatra'
require 'json'

secret_token = ENV['SECRET_TOKEN']
state = :unknown

puts secret_token

get('/update_state') do
  puts params
  return 403 if params['token'] != secret_token
  params['state'] == 'open' ? state = :open : state = :closed
end

get('/') do
  content_type 'text/json'
  response.headers['Access-Control-Allow-Origin'] = '*'
  JSON.generate({state: state})
end

options('/') do
  response.headers['Access-Control-Allow-Origin'] = '*'
  response.headers['Access-Control-Allow-Methods'] = 'GET, PUT, POST, DELETE, OPTIONS'
  response.headers['Access-Control-Allow-Headers'] =  'Content-Type, Authorization, X-Requested-With'
  response.headers['Access-Control-Max-Age'] = '1000'
  200
end
