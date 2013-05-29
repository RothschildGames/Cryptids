module Player
  module Heuristics
    module GameInfo

      def map_opponents_by_energy
        opponents.inject({}) do |hash, player|
          hash[player] = player.energy
          hash
        end
      end

      def strongest_players
        map_opponents_by_energy.keys_with_maximum_value
      end

      def weakest_players
        map_opponents_by_energy.keys_with_maximum_value
      end

      def targeted_count
        game.aim_cards.values.count { |player| player == self }
      end

    end
  end
end