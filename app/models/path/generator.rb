class Path
  class Generator < Struct.new :placeable_locations, :start, :finish, :random
    DeadendException = Class.new StandardError

    def initialize(placeable_locations, start, finish, random)
      start   ||= placeable_locations.sample(random: random)
      finish  ||= placeable_locations.sample(random: random)

      super
    end

    def create_path!
      point=start

      @dead_end_count = 0

      until stop_search?(point)
        here, next_p  = next_point(point)
        path.push(here)

        traversed_points << here
        point = next_p
      end

      if dead_end?(point)
        path.dead_end!
      end

      if start.is_a?(StartPoint)
        path[0] = StartPoint.from path[0]
      end

      path
    end

    def path
      @path ||= Path.new
    end

    def next_point(p)
      points = non_path_points(p)

      if points.any?
        decrement_dead_end_count!
      else
        @dead_end_count += 1

        if @dead_end_count >= 3
          traversed_points << p
          return [p, DeadEnd.from(p)]
        else
          previous_point = path.pop
          if previous_point.nil?
            return [DeadEnd.from(p), DeadEnd.from(p)]
          else
            return next_point(previous_point)
          end
        end
      end

      points.sample(random: random)
    end

    def next_candidate_path_points(here, points=placeable_locations)
      points.map do |other|
        klass = other.adjacent_to?(here)

        [klass.from(here), other] if klass
      end.compact
    end

    private

    def stop_search?(p)
      dead_end?(p) || finish?(p) || visited_everywhere?
    end

    def dead_end?(p)
      p.kind_of?(Path::DeadEnd)
    end

    def finish?(p)
      p.kind_of?(FinishPoint)
    end

    def visited_everywhere?
      traversed_points.length >= placeable_locations.length
    end


    def decrement_dead_end_count!
      @dead_end_count ||= 0
      @dead_end_count = [@dead_end_count - 1, 0].max
    end


    def non_path_points(p)
      candidate_points = next_candidate_path_points(p)

      here, finish = candidate_points.find do |_, next_point|
        next_point.kind_of?(FinishPoint)
      end

      return [[here, finish]] if finish

      candidate_points.reject! do |proposed_point, _|
        path.any? do |existing_point, _|
          proposed_point == existing_point
        end
      end

      candidate_points.reject! do |proposed_point, _|
        traversed_points.include?(proposed_point)
      end

      candidate_points
    end


    def traversed_points
      @traversed_points ||= Set.new
    end
  end


end
