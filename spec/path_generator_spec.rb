require 'spec_helper'

describe PathGenerator do
  let(:maze) { maze_generator.maze }
  let(:maze_generator) { MazeGenerator.new(10,10, random) }
  let(:random) { Random.new 1 }
  let(:generator) { PathGenerator.new(maze_generator, random) }

  it "sanity check" do
    match_grid maze, <<-MAZE
      fwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwws
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
    MAZE
  end

  describe "#points" do
    it "starts at the start" do
      point = generator.points.first

      expect(point).to eq maze_generator.start
    end
  end

  it "adds a path to the maze" do
    with_path = generator.maze

    match_grid with_path, <<-MAZE
      fwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwws
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
    MAZE
  end
end

