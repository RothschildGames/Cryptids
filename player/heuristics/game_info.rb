module Player
  module Heuristics
    module GameInfo

      def map_opponents_by_energy
        opponents.inject({}) do |hash, player|
          hash[player] = player.energy
          hash
        end
      end

      def strongest_player
        map_opponents_by_energy.max_by {|_,v| v}.first
      end

      def weakest_player
        map_opponents_by_energy.min_by {|_,v| v}.first
      end

    end
  end
end