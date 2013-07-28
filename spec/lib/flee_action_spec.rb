require 'spec_helper'
require_relative '../../lib/flee_action'

describe FleeAction do
  let(:hero) { double("hero",
               strength: 3,
               gain_exp: nil,
               gain_gold: nil,
               damage: nil,
               stealth: 3)}
  let(:dicepool) { double("dicepool") }
  let(:action) { FleeAction.new hero, dicepool}
  let(:monster) { double("monster",
                  toughness: 2,
                  kill: nil,
                  damage: 4,
                  notice: 2) }

  it_behaves_like "actionable"
  it_behaves_like "action"

  it "has stealth for attribute" do
    expect(action.attribute).to eq(:stealth)
  end

  it "has notice for difficulty" do
    expect(action.difficulty).to eq(:notice)
  end


  describe "effect" do
    context "success" do
      it "sends flee message to the owner" do
        dicepool.stub(:skill_check).and_return(true)
        hero.should_receive(:flee)
        action.activate(monster)
      end
    end
    context "failure" do
      it "deals damage to the owner" do
        dicepool.stub(:skill_check).and_return(false)
        hero.should_receive(:damage).with(monster.damage)
        action.activate(monster)
      end
    end
  end


end