# I think the way we need to approch the selection of cards is by percentages or points of choosing cards
# Like which cards is better right now than the rest of the cards.
# That way when we start adding race powers, it can just add/subtract points from a specific strategy.
# Also the choose other action is really hard to guess.
module Player
  class Basic < Abstract

    def choose_aim
      threat = biggest_threat
      if !threat.nil?
        return aim_cards.find { |card| card.target == threat }
      end

      weakling = can_be_killed
      if !weakling.nil?
        return aim_cards.find { |card| card.target == weakling }
      end

      aim_cards.sample
    end

    def choose_action
      if in_danger?
        action = :block
      elsif !biggest_threat.nil? || !can_be_killed.nil?
        action = :block
      else
        action = :charge
      end
      return action_cards.find { |card| card.type == action }
    end

    def choose_another_action(excluded_action)
      actions_other_than(excluded_action).sample
    end

    private

    DANGER_ENERGY = 2
    THREAT_ENERGY = 8

    def map_opponents_energy
      opponents.inject({}) do |hash, player|
        hash[player] = player.energy
        hash
      end
    end

    def in_danger?
      @energy < DANGER_ENERGY
    end

    def biggest_threat
      winning_opponents = map_opponents_energy.select do |_, energy|
        energy >= THREAT_ENERGY
      end
      winning_opponents.keys.sample
    end

    def can_be_killed
      opponents_in_danger = map_opponents_energy.select do |_, energy|
        energy <= DANGER_ENERGY
      end
      opponents_in_danger.keys.sample
    end

  end
end
