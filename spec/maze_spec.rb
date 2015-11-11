describe Maze do
  let(:start)  { double(x: 1, y: 0, to_s: "s") }
  let(:finish) { double(x: 8, y: 9, to_s: "f") }

  let(:maze) { Maze.new(10, 10, start, finish) }

  it "generates a grid" do
    match_grid maze.grid, <<-MAZE
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

  describe "#points" do
    it "includes start and finish point" do
      match_grid maze.points, <<-MAZE
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


  end
end


