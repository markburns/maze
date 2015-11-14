class MazeGenerator < Struct.new(:grid, :edge_selector)
  include Visitor::GridVisitable
  attr_writer :path_generator

  delegate :points, to: :maze,   prefix: true


  def points
    rows.flatten
  end

  def rows
    []
  end

  def happy_path_generator
    @happy_path_generator ||= Path::Generator.new(grid.points, start, finish, Random.new)
  end

  def start
    @start ||= new_edge_point(StartPoint)
  end

  def finish
    @finish ||= new_edge_point(FinishPoint)
  end

  private

  def new_edge_point(klass)
    point = edge_selector.next_point

    klass.new(point.x, point.y)
  end
end
