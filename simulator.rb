NUMBER_OF_PLAYERS = 3
STARTING_ENERGY = 5
WINNING_ENERGY = 10

class Race

end

class Card
  attr_accessor :face_up, :owner

  def initialize(owner)
    @face_up = false
    @owner = owner
  end

  def face_up!
    @face_up = true
  end

  def face_up?
    !!@face_up
  end
end

class AimCard < Card
  attr_accessor :target

  def initialize(owner, target)
    super(owner)
    @target = target
  end
end

class ActionCard < Card
  attr_accessor :type
  TYPES = [:attack, :block, :charge]

  def initialize(owner, type)
    super(owner)
    @type = type
  end
end

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
      aim_cards.face_up!
    end
  end
end

class Player
  attr_accessor :energy, :race, :game, :aim_cards, :action_cards

  def initialize
    @energy = STARTING_ENERGY
    @aim_cards = []
    @action_cards = []
  end

  def create_hand
    game.players.each do |other|
      if other != self
        aim_cards << AimCard.new(self, other)
      end
    end
    ActionCard.TYPES.each do |type|
      action_cards << ActionCard.new(self, type)
    end
    #race.extend_hand(self)
  end

  def choose_aim
    aim_cards.sample
  end

  def choose_action
    action_cards.sample
  end


end


game = Game.new()
NUMBER_OF_PLAYERS.times { game.add_player Player.new }
game.start_game
game.turn

puts game