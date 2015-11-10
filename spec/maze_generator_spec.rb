require 'spec_helper'

describe MazeGenerator do
  let(:generator) { MazeGenerator.new(10, 10) }

  it "generates a grid" do
    match_grid generator.grid, <<-MAZE
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
    MAZE
  end

  it "adds a start and finish point" do
    generator.start = StartPoint.new(1, 0)
    generator.finish = FinishPoint.new(8, 9)

    match_grid generator.maze, <<-MAZE
      wswwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwww
      wwwwwwwwfw
      MAZE
  end

  context "with a seeded random number" do
    let(:random) { Random.new 1 }
    let(:generator) { MazeGenerator.new(10, 10, random) }

    it "initializes the start point to a specific random location" do
      expect(generator.start_x).to eq 9
      expect(generator.start_y).to eq 5
    end
  end


end
