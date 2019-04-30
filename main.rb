require_relative 'helpers'

# Get users vanityurl
puts 'Enter gamers vanityurl'
vanityurl = 'tarrinros'

# Steam API key
Steam.apikey = '11456C84FE362A159F2CEC5F7C2F3435'

# Get users ID by vanityurl
steam_id = Steam::User.vanity_to_steamid(vanityurl)
puts "Your ID #{steam_id}"

# Get games list from steam
games_list = Steam::Player.owned_games(steam_id, params: {include_appinfo: 1})

# Get a random game from list
random_game = games_list['games'].sample

# Advise user to play some game
# Show some information about advised game
app_id = random_game['appid']
img_url = random_game['img_logo_url']
game_title = random_game['name']

puts suggest_game(game_title)
puts "Game image: #{game_header(app_id, img_url)}"
puts "Playtime: #{total_playtime(random_game['playtime_forever'])}"

