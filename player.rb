class Player
  attr_accessor :energy, :race, :game, :aim_cards, :action_cards, :name

  def initialize
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
  end

  def choose_aim
    raise '`choose_aim` to be implemented by subclass'
  end

  def choose_action
    raise '`choose_action` to be implemented by subclass'
  end

  def change_action(current_action)
    raise '`change_action` to be implemented by subclass'
  end

  def die
    game.players.delete(self)
  end

  def to_s
    "#@name (#@energy)"
  end

end

class RandomPlayer < Player

  def choose_aim
    aim_cards.sample
  end

  def choose_action
    action_cards.sample
  end

  def change_action(current_action)
    #action_cards.sample
  end

end