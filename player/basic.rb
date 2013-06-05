module Player
  class Basic < Abstract

    def choose_aim
      aim_cards.sample
    end

    def choose_action
      action_cards.sample
    end

    def choose_another_action(excluded_action)
      return action_card_for(:block) if attacked_by_many?

      actions_other_than(excluded_action).sample
    end

    private

    def attacked_by_many?
      targeted_count >= (game.players.length / 2).ceil
    end

  end
end
