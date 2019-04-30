require 'sinatra/base'

class SteamApp < Sinatra::Base
  set :root, File __dir__

  get '/' do
    erb :index
  end
end