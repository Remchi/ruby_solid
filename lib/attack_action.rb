class AttackAction
  attr_reader :owner, :dicepool

  def initialize(owner, dicepool)
    @owner = owner
    @dicepool = dicepool
  end

  def activate(target)
    if dicepool.skill_check(owner.strength, target.toughness)
      success(target)
    else
      failure(target)
    end
  end

  def success(target)
    target.kill
    owner.gain_exp
    owner.gain_gold
  end

  def failure(target)
    owner.damage(target.damage)
  end

end