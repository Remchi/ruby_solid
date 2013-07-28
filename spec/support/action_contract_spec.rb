shared_examples "action" do

  it "responds to action_attributes" do
    expect(action).to respond_to(:action_attributes)
  end


  it "responds to success" do
    expect(action).to respond_to(:success)
  end


  it "responds to failure" do
    expect(action).to respond_to(:failure)
  end


  it "responds to owner" do
    expect(action).to respond_to(:owner)
  end


  it "responds to dicepool" do
    expect(action).to respond_to(:dicepool)
  end


  it "responds to difficulty" do
    expect(action).to respond_to(:difficulty)
  end


  it "responds to attribute" do
    expect(action).to respond_to(:attribute)
  end


  it "responds to activate" do
    expect(action).to respond_to(:activate)
  end
end