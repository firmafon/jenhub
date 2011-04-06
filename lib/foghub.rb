require 'sinatra'
require 'yaml'

get '/job/:job' do
  config = YAML.load_file('./config.yml')
  puts `curl -u "#{config[:username]}:#{config[:password]}" #{config[:jenkins]}/job/#{params[:job]}/build`
end
