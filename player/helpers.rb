module Player
  module Helpers
    def target
      game.aim_cards[self].target
    end

    def action
      game.action_cards[self].action
    end

    def aiming_at_me
      game.aim_cards.select {
          |aim_card| aim_card.target == self
      }.map{
        |aim_card| aim_card.owner
      }
    end

    def attacking?
      action == :attack
    end
  end
end