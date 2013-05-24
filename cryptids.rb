Dir['./player/*.rb'].each {|file| require file }
require './card'
require './race'
require './game'

STARTING_ENERGY = 5
WINNING_ENERGY = 10

game = Game.new(STARTING_ENERGY, WINNING_ENERGY)
game.add_player Player::Random.new
game.add_player Player::Random.new
game.add_player Player::Random.new
game.start_game

while not game.game_ended? do
  game.turn
end