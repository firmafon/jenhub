require 'sinatra'
require 'yaml'

post '/job/:job/:token' do
  config = YAML.load_file('./config.yml')

  if params[:token] == config[:token]
    puts `curl -u "#{config[:username]}:#{config[:password]}" #{config[:jenkins]}/job/#{params[:job]}/build`
  else
    halt 401, 'go away!'
  end
end
