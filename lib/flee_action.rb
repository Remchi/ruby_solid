require_relative 'action'

class FleeAction < Action

  def action_attributes
    @attribute = :stealth
    @difficulty = :notice
  end

  def success(target)
    owner.flee
  end

  def failure(target)
    owner.damage(target.damage)
  end

end