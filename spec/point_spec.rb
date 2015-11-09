describe Point do
  it "has an x" do
    point = Point.new(1,0)
    expect(point.x).to eq 1
  end
  it "has an y" do
    point = Point.new(1,0)
    expect(point.y).to eq 0
  end
end
