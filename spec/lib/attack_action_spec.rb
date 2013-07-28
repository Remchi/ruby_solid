require 'spec_helper'
require_relative '../../lib/attack_action'

describe AttackAction do
  let(:hero) { double("hero", strength: 3, gain_exp: nil, gain_gold: nil, damage: nil)}
  let(:dicepool) { double("dicepool") }
  let(:action) { AttackAction.new hero, dicepool}
  let(:monster) { double("monster", toughness: 2, kill: nil, damage: 4) }

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

  describe "activate" do

    it "makes strength check against target toughness" do
      dicepool.should_receive(:skill_check).with(hero.strength, monster.toughness)
      action.activate(monster)
    end

  end

  it "responds to activate message" do
    expect(action).to respond_to(:activate)
  end

  it "has an owner" do
    expect(action.owner).to eq(hero)
  end

end