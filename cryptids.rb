Dir['./player/*.rb'].each {|file| require file }
require './card'
require './race'
require './game'

STARTING_ENERGY = 5
WINNING_ENERGY = 10

def run_single_game
  game = Game.new(STARTING_ENERGY, WINNING_ENERGY)
  game.add_player Player::Random.new
  game.add_player Player::Random.new
  game.add_player Player::Random.new
  game.logs = false
  game.start_game

  while not game.game_ended? do
    game.turn
  end

  game
end

def run_multiple_games(games = 1000)
  winners = []
  games.times do |i|
    result_game = run_single_game
    winners << result_game.winners
  end

  winners.flatten!
  victories = winners.inject({}) do |hash, player|
    hash[player.name] = 0 if hash[player.name].nil?
    hash[player.name] += 1
    hash
  end
  puts "\nVictories by players after #{games} games:"
  puts victories.sort.to_s
end

run_multiple_games