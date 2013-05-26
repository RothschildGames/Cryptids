class Game
  include Observable

  attr_accessor :players, :aim_cards, :action_cards, :winners, :turn_num

  def initialize(starting_energy, winning_energy)
    @players = []
    @turn_num = 0
    @starting_energy = starting_energy
    @winning_energy = winning_energy
    @game_over_flag = false
    @aim_cards = {}
    @action_cards = {}
    @winners = []
  end

  def add_player(player)
    player.game = self
    player.energy = @starting_energy
    @players << player
  end

  def start_game
    @players.each(&:create_hand)
    notify(:game_start)
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
    @turn_num += 1
    aim_cards.clear
    action_cards.clear
    notify(:turn_start, :turn => @turn_num)
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
      action_cards[player] = new_action if new_action != :do_nothing
    end
  end

  def resolve_actions
    players.each do |player|
      target = aim_cards[player].target
      target_action = action_cards[target].type
      action = action_cards[player].type

      notify(:player_action, :player => player, :action => action, :target => target)

      case action
        when :attack
          case target_action
            when :attack
              target.energy -= 1
              player.energy -= 1
            when :block
              player.energy -= 1
            when :charge
              target.energy -= 1 #(Maybe we need to -2 (because else this is a zero sum turn (+1,-1) ))
          end
        when :charge
          player.energy += 1
      end
    end
  end

  def resolve_end_turn
    winners = []
    players.each do |player|
      player.die if player.dead?
    end
    players.each do |player|
      winners << player if player.energy >= @winning_energy
    end
    game_over(winners) unless winners.empty?
    game_over(players) if players.length <= 1
  end

  def game_over(winners)
    @game_over_flag = true
    @winners = winners
    notify(:game_end, :winners => winners)
  end

  def game_ended?
    @game_over_flag
  end

  def notify(event, data = nil)
    changed
    notify_observers(event, data)
  end

  def win_type
    return :victory_points if players.count > 1
    return :last_man_standing if players.count == 1
    :no_winner
  end

end