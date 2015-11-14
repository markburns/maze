describe Maze do
  let(:start) { double x: 0, y: 0 }
  let(:finish) { double x: 9, y: 5 }
  let(:maze) { Maze.new(10,10,start, finish) }

  it "adds the start point" do
    expect(maze.points[start.y][start.x]).to eq start
  end

  it "adds the finish point" do
    expect(maze.points[finish.y][finish.x]).to eq finish
  end
end
