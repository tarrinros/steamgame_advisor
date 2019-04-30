require 'steam-api'
require 'active_support/duration'
require 'pattern_string_generator'
require 'dotenv'

require 'sinatra/base'

require_relative 'helpers'

Dotenv.load

class SteamApp < Sinatra::Base
  set :root, __dir__

  helpers Sinatra::SteamApp::Helpers

  get '/' do
    erb :index
  end

  get '/suggest_game' do
    vanityurl = params['name']

    # Steam API key
    Steam.apikey = ENV['STEAM_API_KEY']

    # Get users ID by vanityurl
    steam_id = Steam::User.vanity_to_steamid(vanityurl)

    # Get games list from steam
    games_list = Steam::Player.owned_games(steam_id, params: {include_appinfo: 1})

    # Get a random game from list
    random_game = games_list['games'].sample

    # Advise user to play some game
    # Show some information about advised game
    @game_id = random_game['appid']
    @game_img_url = random_game['img_logo_url']
    @game_title = random_game['name']
    @game_playtime = random_game['playtime_forever']

    erb :suggest_game
  end
end