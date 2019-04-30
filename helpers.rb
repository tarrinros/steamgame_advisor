def game_url(id)
  "https://store.steampowered.com/app/#{id}"
end

def game_header(app_id, img_url)
  "http://media.steampowered.com/steamcommunity/public/images/apps/#{app_id}/#{img_url}.jpg"
end

def total_playtime(playtime)
  puts 'You\'ve never played it' if playtime.zero?
  seconds = playtime * 60

  played_time = ActiveSupport::Duration.build(seconds)
  played_time.inspect
end

def advise_game(game_title)
  pattern = "(Let's play|Have a(n awesome| nice) experience with|For example): \"#{game_title}\"".as_pattern
  pattern.to_s
end