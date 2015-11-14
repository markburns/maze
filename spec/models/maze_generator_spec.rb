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

       ▼1  ▶0   x  ▶14 ▶15 ▼16 ▶1  ▶2  ▶2   x
       ▼2  ▶5  ▼6  ▲13 ◀12 ▼17 ▼11 ◀10 ▶1  ▼2
       ▶3  ▲4  ▼7   x  ▲11 ▼18 ▼11 ▲9  ▼4  ◀3
       ▶0   x  ▶8  ▶9  ▲10 ▼19  x  ▲8  ▼5   x
       ▼3  ◀2  ◀1  ▶5  ▼6  ▶20 ▼21 ▲7  ◀6  ▼1
       ▼4  ▶2  ▶3  ▲4  ▼7   x  ▼22 ▶25 ▼26 ▼2
       ▼5  ▲1  ▼19  x  ▶8  ▼9  ▶23 ▲24 ▼27 ▼3
       ▶6  ▼7  ▲19 ◀18  x  ▼10  x  ▼29 ◀28 ▼4
       x  ▼8  ▼1  ▲17 ◀16 ▶11 ▼12 ▼30  x  ◀4
       ▶9  ◀9  ▶1   x  ▲15 ◀14 ◀13 ▶31 ▶32   ◎
        MAZE
      end
    end
  end

end
