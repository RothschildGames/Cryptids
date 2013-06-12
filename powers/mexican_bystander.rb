class MexicanBystander < Power

  def initialize
    @name = 'Mexican Bystander'
    @description = 'If all the players are attacking this turn, you are immune to damage'
    @phase = :resolve_action
  end

  def run

  end

end