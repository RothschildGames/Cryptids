class SolarPowered < Power

  def initialize
    @name = 'Solar Powered'
    @description = 'If no one charges during this turn - gain 1E'
    @phase = :end_of_turn
  end

  def run

  end

end