describe Grid do
  let(:visitor) { Visitor::String.new }
  let(:start)  { StartPoint.new(1, 0) }
  let(:finish) { FinishPoint.new(8, 9) }

  let(:grid) { Grid.new(10, 10, start, finish) }

  it "generates a grid" do
    points = grid.grid_accept(visitor)
    match_grid points, <<-GRID
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
    GRID
  end

  describe "#points" do
    it "includes start and finish point" do
      points = grid.points_accept(visitor)
      match_grid points, <<-GRID
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
      GRID
    end


  end
end


