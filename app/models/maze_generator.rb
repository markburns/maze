class MazeGenerator < Struct.new(:width, :height, :random)
  attr_writer :start, :finish

  delegate :x, :y,  to: :start,  prefix: true
  delegate :x, :y,  to: :finish, prefix: true
  delegate :points, to: :maze,   prefix: true

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
    @maze ||= Maze.new(width, height, start, finish)
  end

  def inspect
    <<-INSPECT
    #<Maze ##{object_id}
    #{maze.map{|r| r.join("")}.join("\n")}
    >
    INSPECT
  end

  private
  def new_point(klass)
    point = edge_selector.next_point

    klass.new(point.x, point.y)
  end

  def edge_selector
    @edge_selector ||= EdgeSelector.new(width, height, random)
  end
end
