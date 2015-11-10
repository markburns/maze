class PathGenerator < Struct.new :maze_generator, :random
  def maze
    maze_generator.maze.tap do |maze|
      add_path!(maze)
    end
  end

  def points
    [maze_generator.start]
  end

  def add_path!(maze)
  end
end
