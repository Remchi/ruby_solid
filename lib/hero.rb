class Hero
  attr_reader :strength, :health, :actions, :gold, :exp, :stealth

  def initialize(attr = {})
    @strength = attr.fetch(:strength, 3)
    @health = attr.fetch(:health, 10)
    @actions = attr.fetch(:actions, {})
    @stealth = attr.fetch(:stealth, 1)

    own_actions

    @gold = 0
    @exp = 0

    @fled = false
  end

  def own_actions
    @actions.each { |key, action| action.assign_owner(self) }
  end

  def dead?
    @health <= 0
  end

  def fled?
    @fled
  end

  def flee
    @fled = true
  end

  def reset_flee
    @fled = false
  end

  def activate_action(action_name, target)
    actions[action_name].activate(target)
  end

  def damage(hit)
    @health -= hit
  end

  def gain_gold(amount)
    @gold += amount
  end

  def gain_exp(amount)
    @exp += amount
  end


end