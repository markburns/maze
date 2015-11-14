describe MazeGenerator do
  let(:start) { double "point", x: 0, y: 0, kind_of?: true }
  let(:finish) { double "point", x: 9, y: 9, kind_of?: true }
  let(:grid) { Grid.new 10,10 }
  let(:edge_selector) { double "edge selector" }

  let(:maze_generator) do
    MazeGenerator.new(grid, edge_selector).tap do |m|
      m.path_generator = path_generator
    end
  end

  let(:path_generator) { Path::Generator.new(grid, start, finish, Random.new(1)) }
  

  before do
    allow(edge_selector).to receive(:next_point).and_return start, finish
  end

  pending "generates a maze" do
    with_paths =  maze_generator.accept(Visitor::String.new)

    match_grid with_paths, <<-MAZE
      wwwff
    MAZE
  end

  it "eliminates all walls" do
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




end
