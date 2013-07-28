require 'spec_helper'

require_relative '../../lib/hero'
require_relative '../../lib/monster'
require_relative '../../lib/attack_action'
require_relative '../../lib/flee_action'
require_relative '../../lib/dicepool'

describe "Battle" do
  let(:hero) { Hero.new strength: 5,
                        health: 10,
                        actions: {
                          attack: AttackAction.new,
                          flee: FleeAction.new
                        }
              }
  let(:monster) { Monster.new toughness: 2,
                              notice: 1,
                              damage: 4,
                              exp: 10,
                              gold: 20
                }

  let(:dicepool) { Dicepool.new }

  describe "Hero attacks monster" do

    context "successful attack" do
      before :each do
        dicepool.stub(:roll_die).and_return(5)
        Dicepool.stub(:new).and_return(dicepool)
        hero.activate_action :attack, monster
      end
      it "kills monster" do
        expect(monster).to be_dead
      end
      it "gets monster's gold" do
        expect(hero.gold).to eq(20)
      end
      it "gets experience" do
        expect(hero.exp).to eq(10)
      end
    end

    context "failed attack" do
      before :each do
        dicepool.stub(:roll_die).and_return(2)
        Dicepool.stub(:new).and_return(dicepool)
        hero.activate_action :attack, monster
      end
      it "takes damage" do
        expect(hero.health).to eq(6)
      end
    end
  end

  describe "Hero flees from monster" do
    context "successful attempt" do
      before :each do
        dicepool.stub(:roll_die).and_return(5)
        Dicepool.stub(:new).and_return(dicepool)
        hero.activate_action :flee, monster
      end
      it "fled" do
        expect(hero.fled?).to be_true
      end
    end
    context "failed attempt" do
      before :each do
        dicepool.stub(:roll_die).and_return(2)
        Dicepool.stub(:new).and_return(dicepool)
        hero.activate_action :flee, monster
      end
      it "taked damage" do
        expect(hero.health).to eq(6)
      end
    end
  end

end