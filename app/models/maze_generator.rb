class MazeGenerator < Struct.new(:width, :height, :random)
  attr_writer :start, :finish

  delegate :x, :y, to: :start,  prefix: true
  delegate :x, :y, to: :finish, prefix: true

  def initialize(width, height, random=Random.new)
    super
  end

  def start
    @start ||= new_point(StartPoint)
  end

  def finish
    @finish ||= new_point(FinishPoint)
  end

  def maze
    grid.tap do |maze|
      add_start!(maze)
      add_finish!(maze)
    end
  end

  def inspect
    <<-INSPECT
    #<Maze ##{object_id}
#{maze.map{|r| r.join("")}.join("\n")}
    >
    INSPECT
  end

  def grid
    height.times.map do |y|
      width.times.map do |x|
        Wall.new(x,y)
      end
    end
  end

  private

  def add_start!(maze)
    maze[start.y][start.x] = start
  end

  def add_finish!(maze)
    maze[finish.y][finish.x] = finish
  end

  def new_point(klass)
    point = edge_selector.next_point

    klass.new(point.x, point.y)
  end

  def edge_selector
    @edge_selector ||= EdgeSelector.new(width, height, random)
  end
end
