require_relative './heuristics/game_info'
require_relative './helpers'

module Player
  class Player::Abstract

    include Player::Heuristics::GameInfo
    include Player::Helpers
    attr_accessor :energy, :race, :game, :aim_cards, :action_cards, :name

    def initialize(name, race = nil)
      @name = name
      @race = race
      @action_cards = []
    end

    def opponents
      game.players.reject { |player| player == self }
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

    def aim_card_for(player)
      aim_cards.find { |card| card.target == player }
    end

    def action_card_for(action)
      action_cards.find { |card| card.type == action }
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

    def choose_another_action(excluded_action)
      raise '`choose_another_action` to be implemented by subclass'
    end

    def dead?
      @energy <= 0
    end

    def die
      game.players.delete(self)
    end

    def name
      "#{self.class.name} #{@name}"
    end

    def to_s
      "#{name} (#@energy)"
    end

    def actions_other_than(action)
      actions = action_cards.reject { |card| card == action }
      #actions << :do_nothing if @energy > 1
      actions
    end

  end
end