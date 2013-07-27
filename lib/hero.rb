class Hero
  attr_reader :strength, :health, :actions

  def initialize(attr = {})
    @strength = attr.fetch(:strength, 3)
    @health = attr.fetch(:health, 10)
    @actions = attr.fetch(:actions, {})
  end

  def activate_action(action_name, target)
    actions[action_name].activate(target)
  end

end