describe Path::Generator do
  let(:grid) {Grid.new 10,10 }
  let(:start) { StartPoint.new 9,5 }
  let(:finish) { FinishPoint.new 0,0 }

  let(:random) { Random.new 1 }
  let(:path_generator) { Path::Generator.new(grid, start, finish, random) }

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

  describe "#define_points!" do
    it "starts at the start" do
      path_generator.define_points!
      point = path_generator.path.first

      expect(point).to eq start
    end
  end

  context "testing visitors" do
    let(:with_path) { path_generator.maze.accept(visitor) }

    context "with a String visitor" do
      let(:visitor) { Visitor::String.new }
      it do
        match_grid with_path, <<-MAZE
          fwwwwwwwww
          ^v<wwwwwww
          ^v^wwv<<ww
          ^<^<w<v^<w
          www^wwv<^w
          www^<<<^vs
          wwwwww<^vw
          wwww<<^v<w
          wwww^<v<ww
          wwwww^<www
        MAZE
      end
    end

    context "with an emoji visitor" do
      let(:visitor) { Visitor::Emoji.new }

      it "adds a path to the maze" do
        match_grid with_path, <<-MAZE
          ◎   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥
        ▲41 ▼36 ◀35   ▥   ▥   ▥   ▥   ▥   ▥   ▥
        ▲40 ▼37 ▲34   ▥   ▥ ▼23 ◀22 ◀21   ▥   ▥
        ▲39 ◀38 ▲33 ◀32   ▥ ▶24 ▼25 ▲20 ◀19   ▥
          ▥   ▥   ▥ ▲31   ▥   ▥ ▼26 ▶17 ▲18   ▥
          ▥   ▥   ▥ ▲30 ◀29 ◀28 ◀27 ▲16 ▼1  🚶
          ▥   ▥   ▥   ▥   ▥   ▥ ▶14 ▲15 ▼2    ▥
          ▥   ▥   ▥   ▥ ▶11 ▶12 ▲13 ▼4  ◀3    ▥
          ▥   ▥   ▥   ▥ ▲10 ◀9  ▼6  ◀5    ▥   ▥
          ▥   ▥   ▥   ▥   ▥ ▲8  ◀7    ▥   ▥   ▥

        MAZE
      end
    end
  end
end

