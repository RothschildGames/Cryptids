module Player
  class Basic < Abstract

    def choose_aim
      threat = strongest_players.sample
      if threat.present?
        return aim_card_for(threat)
      end

      weakling = weakest_players.sample
      if weakling.present?
        return aim_card_for(weakling)
      end

      aim_cards.sample
    end

    def choose_action
      if in_danger?
        action = :block
      elsif strongest_players.sample.present? || weakest_playerss.sample.present?
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

  end
end
