Given /^a player named (.*)$/ do |player|
  full_name = player.split ' '
  player = Player.create first_name: full_name[0], last_name: full_name[1]
  player.teams << Team.new
  player.save
end
