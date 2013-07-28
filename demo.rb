require 'io/console'

require_relative 'lib/hero'
require_relative 'lib/monster'
require_relative 'lib/attack_action'
require_relative 'lib/flee_action'

hero = Hero.new strength: 5, stealth: 5, health: 15, actions: {attack: AttackAction.new, flee: FleeAction.new }

kills = 0
flees = 0

5.times do |number|
  toughness = 1 + rand(3)
  notice    = 1 + rand(2)
  damage    = 1 + rand(4)
  mult      = 1 + rand(3)
  monster = Monster.new toughness: toughness, notice: notice, damage: damage, exp: toughness * mult, gold: damage * mult

  puts "\n\n\n"
  puts "===================================="
  puts "You're fighting MONSTER #{number + 1} with:"
  puts "\ttoughness: #{monster.toughness}"
  puts "\tnotice: #{monster.notice}"
  puts "What do you do? (a) for attack, (f) for flee"
  puts "===================================="

  battle_is_over = false

  until battle_is_over

    if STDIN.getch == 'a'
      hero.activate_action :attack, monster

      if monster.dead?
        puts "YOU WON"
        puts "You gained #{monster.exp} experience"
        puts "Your gained #{monster.gold} gold"
        puts "===================================="
        battle_is_over = true
        kills += 1
      else
        puts "YOU MISSED"
        puts "Monster dealt #{monster.damage} to you"
        puts "You're current health is #{hero.health}"
        puts "===================================="
        battle_is_over = true if hero.dead?
      end

    else
      hero.activate_action :flee, monster

      if hero.fled?
        puts "YOU COWARD"
        puts "===================================="
        battle_is_over = true
        flees += 1
      else
        puts "YOU COULD NOT FLEE"
        puts "Monster dealt #{monster.damage} to you"
        puts "You're current health is #{hero.health}"
        puts "===================================="
        battle_is_over = true if hero.dead?
      end
    end
  end

  break if hero.dead?
  hero.reset_flee
end

if hero.dead?
  puts "\n\nYOU COULDN'T MAKE IT"
else
  puts "\n\nYOU'RE VICTORIOUS"
  puts "You earned #{hero.gold} gold and #{hero.exp} experience"
  puts "You killed #{kills} monsters and fled from #{flees}."
end