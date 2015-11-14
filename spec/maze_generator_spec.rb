describe MazeGenerator do
  let(:point) { double x: 4, y: 5 }
  let(:grid) { double width: 10, height: 10 }
  let(:edge_selector) { double "edge selector" }
  let(:maze_generator) { MazeGenerator.new(grid, edge_selector) }

  it "eliminates all walls" do
    with_paths =  maze_generator.accept(Visitor::String.new)

    maze_string = with_paths.flatten.join(" ")
    expect(maze_string).not_to include "w"
  end

  describe "#start and #finish" do
    before do
      expect(edge_selector).to receive(:next_point).and_return point
    end

    it "initializes the start point" do
      expect(maze_generator.start_x).to eq 4
      expect(maze_generator.start_y).to eq 5
    end

    it "initializes the finish point" do
      expect(maze_generator.finish_x).to eq 4
      expect(maze_generator.finish_y).to eq 5
    end
  end




end
