require 'spec_helper'
require_relative '../../lib/attack_action'

describe AttackAction do
  let(:hero) { double("hero", strength: 3, gain_exp: nil, gain_gold: nil, damage: nil)}
  let(:dicepool) { double("dicepool") }
  let(:action) { AttackAction.new hero, dicepool}
  let(:monster) { double("monster", toughness: 2, kill: nil, damage: 4) }

  it_behaves_like "action"

  it "has strength attribute" do
    expect(action.attribute).to eq(:strength)
  end

  it "has toughness for difficulty" do
    expect(action.difficulty).to eq(:toughness)
  end

  describe "effect" do
    context "success" do
      before :each do
        dicepool.stub(:skill_check).and_return(true)
      end

      it "kills monster" do
        monster.should_receive(:kill)
        action.activate(monster)
      end
      it "rewards owner with exp" do
        hero.should_receive(:gain_exp)
        action.activate(monster)
      end
      it "rewards owner with gold" do
        hero.should_receive(:gain_gold)
        action.activate(monster)
      end
    end
    context "failure" do
      it "damages owner" do
        dicepool.stub(:skill_check).and_return(false)
        hero.should_receive(:damage).with(monster.damage)
        action.activate(monster)
      end
    end
  end

  it "has an owner" do
    expect(action.owner).to eq(hero)
  end

end