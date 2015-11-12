require 'spec_helper'

describe Path::Generator do
  let(:maze) { maze_generator.maze }
  let(:maze_generator) { MazeGenerator.new(10,10, random) }
  let(:random) { Random.new 1 }
  let(:path_generator) { Path::Generator.new(maze_generator, random) }

  describe "#adjacent_points" do
    it do
      result = path_generator.next_path_points(Point.new 2,2)
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
      start_point = maze_generator.start

      _, next_point = path_generator.next_point(start_point)
      expect(next_point).to be_adjacent_to(start_point)
    end
  end

  describe "#define_points!" do
    it "starts at the start" do
      path_generator.define_points!
      point = path_generator.path.first

      expect(point).to eq maze_generator.start
    end
  end

  context "testing visitors" do
    let(:with_path) { path_generator.maze.points_accept(visitor) }

    context "with a String visitor" do
      let(:visitor) { Visitor::String.new }
      it do
        match_grid with_path, <<-MAZE
          fwwwwwwv<w
          ^v<wwwwv^w
          ^v^wwv<<^<
          ^<^<w<v<<^
          www^wwv^<w
          www^<<<w^<
          wwwwwwwwww
          wwwwwwwwww
          wwwwwwwwww
          wwwwwwwwww
        MAZE
      end
    end

    context "with an emoji visitor" do
      let(:visitor) { Visitor::Emoji.new }

      it "adds a path to the maze" do
        match_grid with_path, <<-MAZE
            ◎   ▥   ▥   ▥   ▥   ▥   ▥ ▼11 ◀10   ▥
          ▲33 ▼28 ◀27   ▥   ▥   ▥   ▥ ▼12 ▲9    ▥
          ▲32 ▼29 ▲26   ▥   ▥ ▼15 ◀14 ◀13 ▲8  ◀7
          ▲31 ◀30 ▲25 ◀24   ▥ ▶16 ▼17 ▶4  ▶5  ▲6
            ▥   ▥   ▥ ▲23   ▥   ▥ ▼18 ▲3  ◀2    ▥
            ▥   ▥   ▥ ▲22 ◀21 ◀20 ◀19   ▥ ▲1  ◀0
            ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥
            ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥
            ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥
            ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥
        MAZE
      end
    end
  end
end

