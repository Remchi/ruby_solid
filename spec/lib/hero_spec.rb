require 'spec_helper'
require_relative '../../lib/hero'

describe Hero do
  describe "default attributes" do
    let(:hero) { Hero.new }

    it "has default strength equal to 3" do
      expect(hero.strength).to eq(3)
    end
    it "has default health equal to 10" do
      expect(hero.health).to eq(10)
    end
  end

  it "can be initialized with custom strength" do
    hero = Hero.new strength: 3
    expect(hero.strength).to eq(3)
  end

  it "can be initialized with custom health" do
    hero = Hero.new health: 8
    expect(hero.health).to eq(8)
  end

  describe "attack attack" do
    let(:attack_action) { double("attack_action") }
    let(:hero) { Hero.new actions: { attack: attack_action} }

    it "has attack action" do
      expect(hero.actions[:attack]).to eq(attack_action)
    end

    it "activates attack action" do
      monster = double("monster")
      attack_action.should_receive(:activate)

      hero.activate_action :attack, monster
    end
  end


end