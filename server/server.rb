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
  JSON.generate({state: state})
end
