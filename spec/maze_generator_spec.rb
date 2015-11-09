describe MazeGenerator do
  it "generates a grid" do
    generator = MazeGenerator.new(10, 10)

    expect(generator.grid.chomp).to eq <<-MAZE.strip_heredoc.chomp
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
end
