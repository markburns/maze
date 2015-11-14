class Path
  class Generator < Struct.new :placeable_locations, :start, :finish, :random
    DeadendException = Class.new StandardError

    def initialize(placeable_locations, start, finish, random)
      start   ||= placeable_locations.sample(random: random)
      finish  ||= placeable_locations.sample(random: random)

      super
    end

    def create_path!
      index = 0
      point=start

      @dead_end_count = 0

      until stop_search?(point)
        here, next_p, index = next_point(point, index)
        here.index = index

        path.push(here)

        traversed_points << here
        point = next_p
      end

      if dead_end?(point)
        path.dead_end!
      end

      path
    end

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

    def path
      @path ||= Path.new
    end

    def pretty_path(index)
      @visitor ||= Visitor::Emoji.new
      message = path.accept(@visitor).join("\t")
      puts message
    end

    def next_point(p, index=0)
      points = non_path_points(p, index)

      if points.any?
        @dead_end_count ||= 0
        @dead_end_count = [@dead_end_count - 1, 0].max
      else
        @dead_end_count += 1

        if @dead_end_count >= 3
          traversed_points << p
          return [p, DeadEnd.from(p), index]
        else
          previous_point = path.pop
          if previous_point.nil?
            return [DeadEnd.from(p), DeadEnd.from(p), index-1]
          else
            return next_point(previous_point, index-1)
          end
        end
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
