class Dicepool

  def skill_check(attribute, difficulty)
    dice = []
    attribute.times { dice << roll_die }
    dice.count { |die| die > 4 } >= difficulty
  end

  def roll_die
    1 + rand(6)
  end

end