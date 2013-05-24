class Player
  attr_accessor :energy, :race, :game, :aim_cards, :action_cards, :name

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
    ActionCard::TYPES.each do |type|
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

class Race

end