require 'steam-api'
require 'active_support/duration'
require 'pattern_string_generator'

require 'sinatra/base'

require_relative 'helpers'

class SteamApp < Sinatra::Base
  set :root, __dir__

  helpers Sinatra::SteamApp::Helpers

  get '/' do
    erb :index
  end

  get '/suggest_game' do
    vanityurl = gets.chomp

    # Steam API key
    Steam.apikey = '11456C84FE362A159F2CEC5F7C2F3435'

    # Get users ID by vanityurl
    steam_id = Steam::User.vanity_to_steamid(vanityurl)

    # Get games list from steam
    games_list = Steam::Player.owned_games(steam_id, params: {include_appinfo: 1})

    # Get a random game from list
    random_game = games_list['games'].sample

    # Advise user to play some game
    # Show some information about advised game
    @game_appid = random_game['appid']
    @game_img_url = random_game['img_logo_url']
    @game_title = random_game['name']
    @game_playtime = random_game['playtime_forever']

    erb :suggest_game
  end
end