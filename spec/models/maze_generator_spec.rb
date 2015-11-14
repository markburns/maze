describe MazeGenerator do
  let(:start) { double "point", x: 0, y: 0, kind_of?: true }
  let(:finish) { double "point", x: 9, y: 9, kind_of?: true }
  let(:random) { Random.new 1 }
  let(:grid) { Grid.new 10,10 }
  let(:edge_selector) { EdgeSelector.new grid, random }

  let(:maze_generator) do
    MazeGenerator.new(grid, edge_selector, random).tap do |m|
      m.path_generator = path_generator
    end
  end

  let(:path_generator) { Path::Generator.new(grid, start, finish, Random.new(1)) }

  before do
    allow(edge_selector).to receive(:next_point).and_return start, finish
  end

  it "eliminates all walls" do
    maze_generator.maze
    with_paths =  maze_generator.accept(Visitor::String.new)

    maze_string = with_paths.flatten.join(" ")
    expect(maze_string).not_to include "w"
  end

  describe "#start" do
    before do
      expect(edge_selector).to receive(:next_point).and_return start
    end

    it "initializes the start point" do
      expect(maze_generator.start).to eq start
    end


  end

  describe "#finish" do
    before do
      expect(edge_selector).to receive(:next_point).and_return finish
    end

 
    it "initializes the finish point" do
      expect(maze_generator.finish).to be_a FinishPoint
      expect(maze_generator.finish).to eq finish
    end
  end


  context "generating mazes" do
    let(:with_path) { maze_generator.maze.accept(visitor) }

    context "with a String visitor" do
      let(:visitor) { Visitor::Emoji.new }
      it do
        match_grid with_path, <<-MAZE
        🚶   →  ▥  →  →  ↓  →  →  →  ▥
          ↓  →  ↓  ↑  ←  ↓  ↓  ←  →  ↓
          →  ↑  ↓  ▥  ↑  ↓  ↓  ↑  ↓  ←
          →  ▥  →  →  ↑  ↓  ▥  ↑  ↓  ▥
          ↓  ←  ←  →  ↓  →  ↓  ↑  ←  ↓
          ↓  →  →  ↑  ↓  ▥  ↓  →  ↓  ↓
          ↓  ↑  ↓  ▥  →  ↓  →  ↑  ↓  ↓
          →  ↓  ↑  ←  ▥  ↓  ▥  ↓  ←  ↓
          ▥  ↓  ↓  ↑  ←  →  ↓  ↓  ▥  ←
          →  ←  →  ▥  ↑  ←  ←  →  →  🚪
        MAZE
      end
    end
  end

end
