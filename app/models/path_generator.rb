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

    until p.is_a?(FinishPoint)
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
    points = next_path_points(p)

    points.reject! do |p1|
      Array(@points).any? do |p2|
        p1 == p2
      end
    end

    if points.empty?
      raise PathNotFound.new("no non traversed adjacent points found, for #{p.inspect} in #{maze_generator.maze.inspect}")
    end


    points.sample(random: random)
  end

  def next_path_points(point, points=all_points)
    points.map do |o|
      if o.adjacent_to?(point)
        if o.left_of?(point)
          PathLeft.from(o)
        elsif o.right_of?(point)
          PathRight.from(o)
        elsif o.below?(point)
          PathDown.from(o)
        elsif o.above?(point)
          PathUp.from(o)
        end
      end
    end.compact
  end

  def all_points
    @all_points ||= maze_generator.maze_points.flatten
  end
end
