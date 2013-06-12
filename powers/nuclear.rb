class NuclearPowered < Power

  def initialize
    @name = 'Nuclear Powered'
    @description = 'Charging gains you 1E extra, Lose 2E if attacked while charging'
    @phase = :resolve_action
  end

  def run

  end

end