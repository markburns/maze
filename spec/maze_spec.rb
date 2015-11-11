describe Maze do
  let(:start)  { StartPoint.new(1, 0) }
  let(:finish) { FinishPoint.new(8, 9) }

  let(:maze) { Maze.new(10, 10, start, finish) }

  it "generates a grid" do
    grid = maze.grid_accept(ToStringVisitor.new)
    match_grid grid, <<-MAZE
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
      points = maze.points_accept(ToStringVisitor.new)
      match_grid points, <<-MAZE
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


