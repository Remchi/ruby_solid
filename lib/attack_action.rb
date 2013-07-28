class AttackAction
  attr_reader :owner, :dicepool

  def initialize(owner, dicepool)
    @owner = owner
    @dicepool = dicepool
  end

  def activate(target)
    dicepool.skill_check(owner.strength, target.toughness)
  end

end