Dir['./player/*.rb'].each {|file| require file }
require 'observer'
require './lib/mode'
require './card'
require './race'
require './game'

STARTING_ENERGY = 5
WINNING_ENERGY = 10
SHOULD_LOG = false

def run_single_game
  game = Game.new(STARTING_ENERGY, WINNING_ENERGY)
  GameLogger.new(game) if SHOULD_LOG

  game.add_player Player::Random.new('Player 1')
  game.add_player Player::Random.new('Player 2')
  game.add_player Player::Random.new('Player 3')
  game.start_game

  while not game.game_ended? do
    game.turn
  end

  game
end

def run_multiple_games(games = 1000)
  winners = []
  turns = []
  win_type = []

  games.times do
    result_game = run_single_game
    winners << result_game.winners
    turns << result_game.turn_num
    win_type << result_game.win_type
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
  puts "Games mostly ended with a #{win_type.mode} (#{win_type.percent_of(win_type.mode)})"
  puts "Victory count by players: #{victories.sort.to_s}"
end

run_multiple_games