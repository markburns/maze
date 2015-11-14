class Path
  class Generator < Struct.new :placeable_locations, :start, :finish, :random
    def path
      @path ||= Path.new
    end

    def define_points!
      index = 0
      path.push(point=start)

      until point.is_a?(FinishPoint) || traversed_points.length >= placeable_locations.length
        here, point, index = next_point(point, index)
        here.index = index

        if here == start
          path.push start
        else
          path.push(here)
        end

        traversed_points << here
      end
    end

    def next_point(p, index=0)
      points = non_path_points(p, index)

      if points.empty?
        previous_point = path.pop
        traversed_points << p
        return next_point(previous_point, index-1)
      end

      [*points.sample(random: random), index + 1]
    end


    def next_candidate_path_points(here, index=0, points=placeable_locations)
      points.map do |other|
        if klass = other.adjacent_to?(here)
          [klass.from(here, index), other]
        end
      end.compact
    end

    private

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


    def traversed_points
      @traversed_points ||= Set.new
    end
  end


end
