require 'spec_helper'
require_relative '../../lib/action'

class TestAction < Action
  def action_attributes
    @attribute = :strength
    @difficulty = :toughness
  end
end

describe Action do
  let(:hero) { double("hero", strength: 3, gain_exp: nil, gain_gold: nil, damage: nil)}
  let(:dicepool) { double("dicepool") }
  let(:action) { TestAction.new hero, dicepool}
  let(:monster) { double("monster", toughness: 2, kill: nil, damage: 4) }

  it_behaves_like "action"

end