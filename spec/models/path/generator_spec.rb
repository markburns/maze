describe Path::Generator do
  let(:grid) {Grid.new 10,10 }
  let(:start) { StartPoint.new 9,5 }
  let(:finish) { FinishPoint.new 0,0 }

  let(:random) { Random.new 1 }
  let(:path_generator) { Path::Generator.new(grid.points_of_type(Wall), start, finish, random) }

  describe "#adjacent_points" do
    it do
      result = path_generator.next_candidate_path_points(Point.new 2,2)
      #0123
      #1 .
      #2.x.
      #3 .


      result = result.map &:second
      expect(result).to match_array [
        Path::Left.new(1,2),
        Path::Up.new(2,1),
        Path::Right.new(3,2),
        Path::Down.new(2,3),
      ]
    end
  end

  describe "#next_point" do
    it "fetches an adjacent point" do
      _, next_point = path_generator.next_point(start)
      expect(next_point).to be_adjacent_to(start)
    end
  end

  describe "#create_path!" do
    it "starts at the start" do
      path = path_generator.create_path!

      expect(path.first).to eq start
    end
  end


end

