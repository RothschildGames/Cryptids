module Player
  class Random < Abstract

    def choose_aim
      aim_cards.sample
    end

    def choose_action
      action_cards.sample
    end

    def choose_another_action(other_than)
      (action_cards.reject { |card| card == other_than } << nil).sample
    end

  end
end
