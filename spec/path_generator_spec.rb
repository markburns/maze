require 'spec_helper'

describe PathGenerator do
  let(:maze) { maze_generator.maze }
  let(:maze_generator) { MazeGenerator.new(10,10, random) }
  let(:random) { Random.new 1 }
  let(:generator) { PathGenerator.new(maze_generator, random) }

  describe "#adjacent_points" do
    it do
      result = generator.adjacent_points(Point.new 2,2)
      #0123
      #1 .
      #2.x.
      #3 .

      expect(result).to match_array [
        Point.new(2,1),
        Point.new(1,2),
        Point.new(2,3),
        Point.new(3,2),
      ]
    end
  end

  describe "#next_point" do
    it "fetches an adjacent point" do
      start_point = maze_generator.start

      next_point = generator.next_point(start_point)
      expect(next_point).to be_adjacent_to(start_point)
    end
  end

  describe "#points" do
    it "starts at the start" do
      point = generator.points.first

      expect(point).to eq maze_generator.start
    end
  end

  it "adds a path to the maze" do
    with_path = generator.maze.points_accept(ToStringVisitor.new)

    match_grid with_path, <<-MAZE
       f.........
       ..........
       ..........
       ..........
       ......w...
       ......w..s
       w.....w...
       w.....w...
       ww........
       wwww.ww...
    MAZE
  end
end

