class Hero
  attr_reader :strength, :health

  def initialize(attr = {})
    @strength = attr.fetch(:strength, 3)
    @health = attr.fetch(:health, 10)

    @dicepool = attr.fetch(:dicepool)
  end

  def attack(monster)
    @dicepool.skill_check(strength) >= monster.toughness
  end
end