class Hero
  attr_reader :health, :strength, :stealth

  def initialize(health, strength, stealth)
    @health = health
    @strength = strength
    @stealth = stealth
    @fled = false
  end

  def fled?
    @fled
  end

  def flee(monster)
    dice = []
    stealth.times { dice << 1 + rand(6) }
    successes = dice.count { |die| die > 4 }
    if successes >= monster.notice
      @fled = true
    end
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
  attr_reader :toughness, :damage, :notice

  def initialize(toughness, damage, notice)
    @toughness = toughness
    @damage = damage
    @notice = notice
  end
end

hero = Hero.new 10, 3, 3
monster = Monster.new 2, 4, 2

until hero.attack(monster) || hero.dead? || hero.fled?
  puts "You missed. Monster dealt #{monster.damage} damage"
  puts "Your current health is #{hero.health}"

  puts "Trying to flee"
  hero.flee(monster)
end

puts "===================================="

if hero.dead?
  puts "You LOST"
elsif hero.fled?
  puts "You COWARD"
else
  puts "You WON"
end

puts "===================================="