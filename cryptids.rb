Dir['./player/*.rb'].each {|file| require file }
require 'observer'
require './card'
require './race'
require './game'

STARTING_ENERGY = 5
WINNING_ENERGY = 10
SHOULD_LOG = false

def run_single_game
  game = Game.new(STARTING_ENERGY, WINNING_ENERGY)
  GameLogger.new(game) if SHOULD_LOG

  game.add_player Player::Random.new
  game.add_player Player::Random.new
  game.add_player Player::Random.new
  game.start_game

  while not game.game_ended? do
    game.turn
  end

  game
end

def run_multiple_games(games = 1000)
  winners = []
  turns = []

  games.times do
    result_game = run_single_game
    winners << result_game.winners
    turns << result_game.turn_num
  end

  average_turn = turns.reduce(:+).to_f / turns.length

  winners.flatten!
  victories = winners.inject({}) do |hash, player|
    hash[player.name] = 0 if hash[player.name].nil?
    hash[player.name] += 1
    hash
  end

  puts "Played #{games} games"
  puts "Game ended at turn #{average_turn} averagely"
  puts "Victory count by players:"
  puts victories.sort.to_s
end

run_multiple_games