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
        "w"
      end
    end
  end

  def maze
    maze = grid()

    maze[start_y][start_x]="s"
    maze
  end
end
