require 'steam-api'
require 'active_support/duration'
require 'pattern_string_generator'
require 'dotenv'

require 'sinatra/base'

require_relative 'helpers'

Dotenv.load

class SteamApp < Sinatra::Base
  class NoSteamGamesError < StandardError; end

  set :root, __dir__

  helpers Sinatra::SteamApp::Helpers

  disable :show_exceptions

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

    raise NoSteamGamesError if games_list.empty?

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

  error Steam::SteamError do
    @error = 'This account does not exists or is a private'
    erb :index
  end

  error NoSteamGamesError do
    @error = 'This account doesn\'t have any games'
    erb :index
  end
end