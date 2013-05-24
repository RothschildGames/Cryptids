require './card'
require './player'

NUMBER_OF_PLAYERS = 3
STARTING_ENERGY = 5
WINNING_ENERGY = 10

class Turn
  PHASES = [
      :choose,
      :reveal_aim,
      :change_action,
      :reveal_action,
      :cleanup
  ]
end

class Game
  attr_accessor :players

  def initialize
    @players = []
  end

  def add_player(player)
    player.game = self
    self.players << player
  end

  def start_game
    players.each do |player|
      player.create_hand
    end
  end

  def turn
    aim_cards = []
    action_cards = []

    players.each do |player|
      aim_cards << player.choose_aim
      action_cards << player.choose_action
    end

    aim_cards.each do |card|
      card.face_up!
    end
  end
end

game = Game.new()
NUMBER_OF_PLAYERS.times { game.add_player Player.new }
game.start_game
game.turn

puts game