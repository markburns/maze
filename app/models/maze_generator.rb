class MazeGenerator < Struct.new(:grid, :edge_selector)
  include Visitor::GridVisitable

  delegate :x, :y,  to: :start,  prefix: true
  delegate :x, :y,  to: :finish, prefix: true
  delegate :points, to: :maze,   prefix: true


  def points
    []
  end

  def start
    @start ||= new_point(StartPoint)
  end

  def finish
    @finish ||= new_point(FinishPoint)
  end

  private

  def new_point(klass)
    point = edge_selector.next_point

    klass.new(point.x, point.y)
  end
end
