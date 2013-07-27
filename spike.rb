class Hero
  attr_reader :health, :strength

  def initialize(health, strength)
    @health = health
    @strength = strength
  end

  def attack(monster)
    dice = []
    strength.times { dice << 1 + rand(6) }
    successes = dice.count { |die| die > 4 }
    if successes >= monster.toughness
      return true
    else
      @health -= monster.damage
      return false
    end
  end

  def dead?
    @health <= 0
  end
end

class Monster
  attr_reader :toughness, :damage

  def initialize(toughness, damage)
    @toughness = toughness
    @damage = damage
  end
end

hero = Hero.new 10, 3
monster = Monster.new 2, 4

until hero.attack(monster) || hero.dead?
  puts "You missed. Monster dealt #{monster.damage} damage"
  puts "Your current health is #{hero.health}"
end

puts "===================================="

if hero.dead?
  puts "You LOST"
else
  puts "You WON"
end

puts "===================================="