describe EdgeSelector do
  let(:selector) { EdgeSelector.new(10,10, random) }
  let(:random) { Random.new 10 }

  it "selects a random point on the edge of a grid" do
    100.times do
      point = selector.next_point
      expect(point).to be_a Point
      expect(selector.edge?(point)).to eq true
    end
  end

  describe "#edge?" do
    [
      [0,0, true], #left side
      [0,1, true],
      [0,2, true],
      [0,3, true],
      [0,4, true],

      [1,0, true], #top side
      [2,0, true],
      [3,0, true],

      [9,0, true], #right side
      [9,1, true],
      [9,2, true],
      [9,3, true],
      [9,4, true],


      [0,9, true], #bottom side
      [1,9, true],
      [2,9, true],

      #             #######
      [1,1, false], #x
      [2,2, false], # x
      [3,3, false], #  x
      [2,3, false], #  x x
      [4,3, false],
    ].each do |x,y, expected|
      it "expects point #{x}, #{y} to #{expected ? 'be on the edge' : 'not be on the edge'}" do
        point = Point.new(x,y)

        expect(selector.edge?(point)).to eq expected
      end
    end

  end
end
