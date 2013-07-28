require_relative 'action'

class AttackAction
  include Actionable

  def action_attributes
    @attribute = :strength
    @difficulty = :toughness
  end

  def success(target)
    target.kill
    owner.gain_exp(target.exp)
    owner.gain_gold(target.gold)
  end

  def failure(target)
    owner.damage(target.damage)
  end

end