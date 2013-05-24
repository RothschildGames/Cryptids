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
    @turn = 0
    @game_over_flag = false
  end

  def add_player(player)
    player.game = self
    self.players << player
    player.name = "#Player #{players.length}"
  end

  def start_game
    players.each do |player|
      player.create_hand
    end
  end

  def turn
    @turn += 1

    aim_cards = {}
    action_cards = {}

    defenders = {}
    chargers = {}
    attackers = {}
    under_attack = {}

    players.each do |player|
      aim_card = player.choose_aim
      aim_cards[player] = aim_card

      action_card = player.choose_action
      action_cards[player] = action_card

      if action_card.attack?
        attackers[player] = aim_card.target
        under_attack[aim_card.target] = player
      elsif action_card.defense?
        defenders[player] = true
      elsif action_card.charge?
        chargers[player] = true
      end
    end

    aim_cards.each do |_, card|
      card.face_up!
    end

    action_cards.each do |player, action_card|

      if action_card.attack?
        target = aim_cards[player].target
        if !defenders[target].nil?
          player.energy -= 1
        elsif !chargers[target].nil?
          # do nothing for me
        elsif !attackers[target].nil?
          player.energy -= 1
        end

      elsif action_card.defense?
        if !under_attack[player].nil?
          # do nothing for me
        else
          # do nothing for me
        end

      elsif action_card.charge?
        if !under_attack[player].nil?
          player.energy -= 1
        else
          player.energy += 1
        end
      end

    end

    losers = []
    @players.each do |player|
      losers << player if player.energy <= 0
    end

    unless losers.empty?
      puts "Losers: #{losers.map(&:name)} at turn number #{@turn}"
      @players = @players - losers
    end

    if players.length == 1
      winners = players
    elsif players.length == 0
      game_over(nil)
    else
      winners = []
    end

    players.each do |player|
      winners << player if player.energy >= WINNING_ENERGY
    end
    game_over(winners) unless winners.empty?

  end

  def game_over(winners)
    @game_over_flag = true
    if winners.nil?
      puts "Everyone lost at turn number #{@turn}"
    else
      puts "Winners: #{winners.map(&:name)} at turn number #{@turn}"
    end
  end

  def game_ended?
    @game_over_flag
  end
end

game = Game.new()
NUMBER_OF_PLAYERS.times { game.add_player Player.new }
game.start_game

500.times { game.turn; break if game.game_ended? }

puts game