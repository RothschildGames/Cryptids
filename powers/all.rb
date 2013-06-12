require_relative './power'
require_relative './solar'
require_relative './nuclear'

class Power

  def self.all_powers
    [SolarPowered, NuclearPowered]
  end

end