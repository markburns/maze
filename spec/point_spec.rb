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
      expect_adjacent_to([2,1], [3,1], Path::Left)
      expect_adjacent_to([0,2], [1,2], Path::Left)
    end

    it "in the vertical case" do
      expect_adjacent_to([2,1], [2,2], Path::Up)
      expect_adjacent_to([5,4], [5,5], Path::Up)
      expect_adjacent_to([5,4], [5,3], Path::Down)
    end

    def expect_adjacent_to(a,b,expected)
      expect_next_to(a,b, :adjacent_to?, expected)
    end
  end

  describe "#horizontally_adjacent?" do
    it do
      expect_horizontally_adjacent_to([2,1], [3,1], true)
      expect_horizontally_adjacent_to([0,2], [1,2], true)
    end

    it "negative case" do
      expect_horizontally_adjacent_to([5,5], [3,5], false)
      expect_horizontally_adjacent_to([5,5], [7,5], false)
      expect_horizontally_adjacent_to([6,6], [7,7], false)
    end

    def expect_horizontally_adjacent_to(a,b,expected)
      expect_next_to(a,b, :horizontally_adjacent_to?, expected)
    end
  end

  describe "#vertically_adjacent?" do
    it do
      expect_vertically_adjacent_to([2,1], [2,2], true)
      expect_vertically_adjacent_to([5,4], [5,5], true)
    end

    it "negative case" do
      expect_vertically_adjacent_to([5,5], [3,3], false)
      expect_vertically_adjacent_to([5,5], [5,7], false)
      expect_vertically_adjacent_to([5,5], [5,1], false)
    end

    def expect_vertically_adjacent_to(a,b,expected)
      expect_next_to(a,b, :vertically_adjacent_to?, expected)
    end
  end

  describe "#left_of?" do
    it do
      expect_left_of([2,1],[3,1], true)
      expect_left_of([0,2],[1,2], true)
    end

    it "negative case" do
      expect_left_of([5,5],[4,5], false)
      expect_left_of([5,5],[3,5], false)
      expect_left_of([5,5],[7,5], false)
      expect_left_of([6,6],[7,7], false)
    end

    def expect_left_of(a,b,expected)
      expect_next_to(a,b, :left_of?, expected)
    end
  end

  describe "#right_of?" do
    it do
      expect_right_of([2,1],[1,1], true)
      expect_right_of([4,2],[3,2], true)
    end

    it "negative case" do
      expect_right_of([5,5],[3,5], false)
      expect_right_of([5,5],[6,5], false)
      expect_right_of([5,5],[7,5], false)
      expect_right_of([6,6],[7,7], false)
    end

    def expect_right_of(a,b,expected)
      expect_next_to(a,b, :right_of?, expected)
    end
  end

  describe "#below?" do
    it do
      expect_below([2,2],[2,1], true)
      expect_below([4,2],[4,1], true)
    end

    it "negative case" do
      expect_below([5,5],[5,3], false)
      expect_below([5,5],[4,4], false)
      expect_below([5,5],[5,6], false)
      expect_below([6,6],[7,7], false)
    end

    def expect_below(a,b,expected)
      expect_next_to(a,b, :below?, expected)
    end
  end

  describe "#above?" do
    it do
      expect_above([2,2],[2,3], true)
      expect_above([4,2],[4,3], true)
    end

    it "negative case" do
      expect_above([5,5],[5,4], false)
      expect_above([5,5],[4,4], false)
      expect_above([5,5],[5,7], false)
      expect_above([6,6],[7,7], false)
    end

    def expect_above(a,b,expected)
      expect_next_to(a,b, :above?, expected)
    end
  end

  def expect_next_to(a,b,type,expected)
    a = Point.new(*a)
    b = Point.new(*b)

    expect(a.send(type,b)).to eq expected
  end
end
