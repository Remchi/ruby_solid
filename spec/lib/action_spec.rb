require 'spec_helper'
require_relative '../../lib/action'

class TestAction
  include Actionable
  def action_attributes
    @attribute = :strength
    @difficulty = :toughness
  end
end

describe Actionable do
  let(:hero) { double("hero", strength: 3, gain_exp: nil, gain_gold: nil, damage: nil)}
  let(:dicepool) { double("dicepool") }
  let(:action) { TestAction.new hero}
  let(:monster) { double("monster", toughness: 2, kill: nil, damage: 4) }

  it_behaves_like "action"

  it "requires action attributes to be implemented" do
    expect { Action.new hero }.to raise_exception
  end

  describe "activate" do
    before :each do
      Dicepool.stub(:new).and_return(dicepool)
    end
    it "sends success message if skill check is successful" do
      dicepool.stub(:skill_check).and_return(true)
      action.should_receive(:success)
      action.activate(monster)
    end
    it "sends failure message if skill check is not successful" do
      dicepool.stub(:skill_check).and_return(false)
      action.should_receive(:failure)
      action.activate(monster)
    end
  end

end