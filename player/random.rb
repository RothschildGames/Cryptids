module Player
  class Random < Abstract

    def choose_aim
      aim_cards.sample
    end

    def choose_action
      action_cards.sample
    end

    def choose_another_action(excluded_action)
      return :do_nothing if @energy == 1

      actions_other_than(excluded_action).sample
    end

  end
end
