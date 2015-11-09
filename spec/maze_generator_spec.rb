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

  it "adds a start point" do
    generator.start_x = 1
    generator.start_y = 0

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
      wwwwwwwwww
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

  def format_grid(grid)
    grid.map do |row|
      row.join("")
    end.join("\n")
  end

  def match_grid(a, b)
    expect(format_grid(a)).to eq b.strip_heredoc.chomp
  end
end
