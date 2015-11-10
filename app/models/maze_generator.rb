class MazeGenerator < Struct.new(:width, :height, :random)
  attr_accessor :start_x, :start_y

  def initialize(width, height, random=Random.new)
    super
    selector = EdgeSelector.new(width, height, random)

    point = selector.next_point
    @start_x = point.x
    @start_y = point.y
  end

  def grid
    height.times.map do |y|
      width.times.map do |x|
        Wall.new(x,y)
      end
    end
  end

  def maze
    grid.tap do |maze|
      maze[start.y][start.x] = start
    end
  end

  def start
    @start ||= StartPoint.new(start_x, start_y)
  end

  class Wall < Point
    def to_s
      "w"
    end
  end

  class StartPoint < Point
    def to_s
      "s"
    end
  end
end
