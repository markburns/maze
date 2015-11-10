describe Point do
  let(:point) { Point.new(1,0) }

  it "has an x" do
    expect(point.x).to eq 1
  end

  it "has an y" do
    expect(point.y).to eq 0
  end

  describe "#adjacent_to?" do
    it "in the horizontal case" do
      expect(Point.new(2,1)).to be_adjacent_to Point.new(3,1)
      expect(Point.new(0,2)).to be_adjacent_to Point.new(1,2)
    end

    it "in the vertical case" do
      expect(Point.new(2,1)).to be_adjacent_to Point.new(2,2)
      expect(Point.new(5,4)).to be_adjacent_to Point.new(5,5)
    end
  end

  describe "#horizontally_adjacent?" do
    it do
      expect(Point.new(2,1)).to be_horizontally_adjacent_to Point.new(3,1)
      expect(Point.new(0,2)).to be_horizontally_adjacent_to Point.new(1,2)
    end

    it "negative case" do
      expect(Point.new(5,5)).not_to be_vertically_adjacent_to Point.new(3,5)
      expect(Point.new(5,5)).not_to be_vertically_adjacent_to Point.new(7,5)
      expect(Point.new(6,6)).not_to be_vertically_adjacent_to Point.new(7,7)
    end
  end

  describe "#vertically_adjacent?" do
    it do
      expect(Point.new(2,1)).to be_vertically_adjacent_to Point.new(2,2)
      expect(Point.new(5,4)).to be_vertically_adjacent_to Point.new(5,5)
    end

    it "negative case" do
      expect(Point.new(5,5)).not_to be_horizontally_adjacent_to Point.new(3,3)
      expect(Point.new(5,5)).not_to be_horizontally_adjacent_to Point.new(5,7)
      expect(Point.new(5,5)).not_to be_horizontally_adjacent_to Point.new(5,1)
    end

  end

end
