class Player
  attr_accessor :energy, :race, :game, :aim_cards, :action_cards, :name

  def initialize
    @energy = STARTING_ENERGY
    @action_cards = []
  end

  def aim_cards
    aim_cards = []
    game.players.each do |other|
      if other != self
        aim_cards << AimCard.new(self, other)
      end
    end
    aim_cards
  end

  def create_hand
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

  def die
    game.players.delete(self)
  end

  def to_s
    "#@name (#@energy)"
  end

end

class Race

end