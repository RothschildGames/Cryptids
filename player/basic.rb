module Player
  class Basic < Abstract

    def choose_aim
      threat = strongest_player
      if threat.present?
        return aim_card_for(threat)
      end

      weakling = weakest_player
      if weakling.present?
        return aim_card_for(weakling)
      end

      aim_cards.sample
    end

    def choose_action
      if in_danger?
        action = :block
      elsif strongest_player.present? || weakest_players.present?
        action = :block
      else
        action = :charge
      end
      return action_card_for(action)
    end

    def choose_another_action(excluded_action)
      actions_other_than(excluded_action).sample
    end

    private

    def in_danger?
      @energy < 2
    end

  end
end
