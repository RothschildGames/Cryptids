class ActionResolver

  attr_accessor :player, :result

  class Result < Struct.new(:player, :target)
    def ===(other)
      player == other[0] && target == other[1]
    end

  end

  def initialize(player)
    @player = player
  end

  def resolve
    @result = Result.new(0,0)
    case player.action
      when :attack
        resolve_attack
      when :charge
        resolve_charge
      when :block
        resolve_block
    end
    @result
  end

  def resolve_attack
    case player.target.action
      when :attack
        result.target -= 1
        result.player -= 1 if target_aiming_at_me
      when :charge
        result.target -= 1
      when :block
        if target_aiming_at_me
          result.player -= 2
        else
          result.player -= 1
        end
    end
  end

  def resolve_charge
    return if anyone_attacking_me?
    case player.target.action
      when :attack, :block
        result.player += 1
      when :charge
        if target_aiming_at_me
          result.player = 0
        else
          result.player += 2
        end
    end
  end

  def resolve_block

  end

  def target_aiming_at_me
    player.target.target == player
  end

  def anyone_attacking_me?
    player.aiming_at_me.any?(&:attacking?)
  end

end