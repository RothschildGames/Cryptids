require './card'
require './player'
require './race'

STARTING_ENERGY = 5
WINNING_ENERGY = 10

class Game
  attr_accessor :players, :aim_cards, :action_cards

  def initialize(starting_energy, winning_energy)
    @players = []
    @turn = 0
    @starting_energy = starting_energy
    @winning_energy = winning_energy
    @game_over_flag = false
    @aim_cards = {}
    @action_cards = {}
  end

  def add_player(player)
    player.game = self
    @players << player
    player.energy = @starting_energy
    player.name = "#Player #{@players.length}"
  end

  def start_game
    @players.each do |player|
      player.create_hand
    end
  end

  def turn
    start_turn
    choose_cards
    show_aim_cards
    change_actions
    resolve_actions
    resolve_end_turn
  end

  def start_turn
    @turn += 1
    aim_cards.clear
    action_cards.clear
    puts "\n--- TURN #{@turn} ---"
  end

  def choose_cards
    players.each do |player|
      aim_cards[player] = player.choose_aim
      action_cards[player] = player.choose_action
    end
  end


  def show_aim_cards
    aim_cards.values.each(&:face_up!)
  end

  def change_actions
    players.each do |player|
      new_action = player.choose_another_action(action_cards[player])
      action_cards[player] = new_action if !new_action.nil?
    end
  end

  def resolve_actions
    players.each do |player|
      target = aim_cards[player].target
      target_action = action_cards[target].type
      action = action_cards[player].type

      case action
        when :attack
          puts "#{player} attacks #{target}"
        when :block
          puts "#{player} defends"
        when :charge
          puts "#{player} charges (#{player.energy + 1})"
      end

      case action
        when :attack
          case target_action
            when :attack
              target.energy -= 1
              player.energy -= 1
            when :block
              player.energy -= 1
            when :charge
              target.energy -= 1
          end
        when :charge
          player.energy += 1
      end
    end
  end

  def resolve_end_turn
    winners = []
    players.each do |player|
      player.die if player.energy <= 0
    end
    players.each do |player|
      winners << player if player.energy >= @winning_energy
    end
    game_over(winners) unless winners.empty?
    if players.length == 0
      game_over(nil)
    end
    if players.length == 1
      game_over(players)
    end
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


game = Game.new(STARTING_ENERGY, WINNING_ENERGY)
game.add_player RandomPlayer.new
game.add_player RandomPlayer.new
game.add_player RandomPlayer.new
game.start_game

while not game.game_ended? do
  game.turn
end