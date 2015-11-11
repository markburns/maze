class PathGenerator < Struct.new :maze_generator, :random
  PathNotFound = Class.new ::StandardError

  def maze
    maze_generator.maze.tap do |maze|
      add_path!(maze)
    end
  end

  def points
    @points ||= define_points
  end

  def define_points
    @points = [maze_generator.start]
    p = next_point(maze_generator.start)

    while !p.is_a?(FinishPoint)
      @points << PathPoint.from(p)

      p = next_point p
    end

    @points
  end

  def add_path!(maze)
    points.each do |p|
      maze.set_point(p)
    end
  end

  def next_point(p)
    points = candidate_points(p)

    if points.empty?
      raise PathNotFound.new("no candidate adjacent points found, for #{p.inspect} in #{maze_generator.inspect}")
    end

    points.sample(random: random)
  end

  def candidate_points(p)
    adjacent_points(p).
      reject{|p| Array(@points).include?(p) }.
      select{|p| p.is_a?(Wall) || p.is_a?(FinishPoint) }
  end


  def adjacent_points(point)
    maze_generator.maze_points.flatten.select do |o|
      o.adjacent_to?(point)
    end
  end
end
