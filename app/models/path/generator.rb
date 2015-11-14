class Path
  class Generator < Struct.new :grid, :start, :finish, :random
    def maze
      @maze ||= grid.tap do |maze|
        maze.set_points(start, finish)
        define_points!
        maze.set_points(*path.each)
      end
    end

    def path
      @path ||= Path.new
    end

    def define_points!
      index = 0
      path.push(point=start)
      @traversed_points = Set.new

      until point.is_a?(FinishPoint) || @traversed_points.length >= grid.num_points
        here, point, index = next_point(point, index)
        here.index = index
        if here == start
          path.push start
        else
          path.push(here)
        end
        @traversed_points << here
      end
    end

    def next_point(p, index=0)
      points = non_path_points(p, index)

      if points.empty?
        previous_point = path.pop
        @traversed_points << p
        return next_point(previous_point, index-1)
      end

      [*points.sample(random: random), index + 1]
    end

    def non_path_points(p, index)
      candidate_points = next_candidate_path_points(p, index)

      here, finish = candidate_points.find do |here, next_point|
        next_point.kind_of?(FinishPoint)
      end

      return [[here, finish]] if finish

      candidate_points.reject! do |proposed_point, _|
        path.any? do |existing_point, _|
          proposed_point == existing_point
        end
      end

      candidate_points
    end

    def next_candidate_path_points(here, index=0, points=all_points)
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
