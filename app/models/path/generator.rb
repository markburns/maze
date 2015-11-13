class Path
  class Generator < Struct.new :grid, :start, :finish, :random
    def maze
      @maze ||= grid.tap do |maze|
        define_points!
        maze.set_points(start, finish)
        maze.set_points(*path.each)
      end
    end

    def path
      @path ||= Path.new
    end

    def define_points!
      index = 0
      point = start
      path << point

      until point.is_a?(FinishPoint)
        here, point, index = next_point(point, index)
        here.index = index
        path.push(here)
      end
    end

    def next_point(p, index=0)
      points = non_traversed_points(p, index)

      if points.empty?
        previous_point = path.pop
        return next_point(previous_point, index-1)
      end

      [*points.sample(random: random), index + 1]
    end

    def non_traversed_points(p, index)
      points = next_path_points(p, index)

      here, finish = points.find do |here, next_point|
        next_point.kind_of?(FinishPoint)
      end

      if finish
        return [[here, finish]]
      end

      points.reject! do |p1, _|
        path.any? do |here, next_point|
          p1 == next_point || p1 ==here
        end
      end

      points
    end

    def next_path_points(here, index=0, points=all_points)
      points.map do |other|
        if klass = other.adjacent_to?(here)
          [klass.from(here, index), other]
        end
      end.compact
    end

    def all_points
      @all_points ||= grid.points.flatten
    end
  end
end
