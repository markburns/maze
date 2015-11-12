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
      expect_adjacent_to([2,1], [3,1], true)
      expect_adjacent_to([0,2], [1,2], true)
    end

    it "in the vertical case" do
      expect_adjacent_to([2,1], [2,2], true)
      expect_adjacent_to([5,4], [5,5], true)
      expect_adjacent_to([5,4], [5,5], true)
    end
  end

  def expect_adjacent_to(a,b,expected)
    a = Point.new(*a)
    b = Point.new(*b)

    expect(a.adjacent_to? b).to eq expected
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

  describe "#left_of?" do
    it do
      expect(Point.new(2,1)).to be_left_of Point.new(3,1)
      expect(Point.new(0,2)).to be_left_of Point.new(1,2)
    end

    it "negative case" do
      expect(Point.new(5,5)).not_to be_left_of Point.new(4,5)
      expect(Point.new(5,5)).not_to be_left_of Point.new(3,5)
      expect(Point.new(5,5)).not_to be_left_of Point.new(7,5)
      expect(Point.new(6,6)).not_to be_left_of Point.new(7,7)
    end
  end

  describe "#right_of?" do
    it do
      expect(Point.new(2,1)).to be_right_of Point.new(1,1)
      expect(Point.new(4,2)).to be_right_of Point.new(3,2)
    end

    it "negative case" do
      expect(Point.new(5,5)).not_to be_right_of Point.new(3,5)
      expect(Point.new(5,5)).not_to be_right_of Point.new(6,5)
      expect(Point.new(5,5)).not_to be_right_of Point.new(7,5)
      expect(Point.new(6,6)).not_to be_right_of Point.new(7,7)
    end
  end

  describe "#below?" do
    it do
      expect(Point.new(2,2)).to be_below Point.new(2,1)
      expect(Point.new(4,2)).to be_below Point.new(4,1)
    end

    it "negative case" do
      expect(Point.new(5,5)).not_to be_below Point.new(5,3)
      expect(Point.new(5,5)).not_to be_below Point.new(4,4)
      expect(Point.new(5,5)).not_to be_below Point.new(5,6)
      expect(Point.new(6,6)).not_to be_below Point.new(7,7)
    end
  end

  describe "#above?" do
    it do
      expect(Point.new(2,2)).to be_above Point.new(2,3)
      expect(Point.new(4,2)).to be_above Point.new(4,3)
    end

    it "negative case" do
      expect(Point.new(5,5)).not_to be_above Point.new(5,4)
      expect(Point.new(5,5)).not_to be_above Point.new(4,4)
      expect(Point.new(5,5)).not_to be_above Point.new(5,7)
      expect(Point.new(6,6)).not_to be_above Point.new(7,7)
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
