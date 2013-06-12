class Power

  attr_accessor :player, :name, :description, :phase

  PHASES = [
        :start_of_game,
        :start_of_turn,
        :choose,
        :aim,
        :change,
        :action,
        :resolve,
        :end_of_turn,
        :cleanup
  ]

  def initialize
    @name = 'POWER NAME'
    @description = 'POWER DESCRIPTION'
    @phase = :first
  end

  def run

  end

end