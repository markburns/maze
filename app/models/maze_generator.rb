class MazeGenerator < Struct.new(:grid, :edge_selector, :random)
  include Visitor::GridVisitable
  attr_writer :path_generator

  delegate :points, to: :maze,   prefix: true
  delegate :rows, to: :maze

  def maze
    @maze ||= create_maze_with_paths!
  end

  def create_maze_with_paths!
    path = create_happy_path!
    @maze.set_points(*path)

    remove_all_walls!

    @maze
  end

  def create_happy_path!
    path = nil

    begin
      create_maze!
      path = happy_path_generator.create_path!
    end until path && !path.dead_end

    path
  end

  def remove_all_walls!
    remove_walls!  while walls_remaining?
  end

  def remove_walls!
    path = wall_path_generator.create_path!

    @maze.set_points(*path)
  end

  def wall_points
    @maze.points_of_type(Wall)
  end

  def walls_remaining?
    wall_points.length > 0
  end

  def create_maze!
    @maze ||= Maze.new(grid.width, grid.height, start, finish)
  end

  def points
    rows.flatten
  end


  def start
    @start ||= new_edge_point(StartPoint)
  end

  def finish
    @finish ||= new_edge_point(FinishPoint)
  end

  private

  def happy_path_generator
    Path::Generator.new(
      @maze.points_of_type(Wall, StartPoint, FinishPoint),
      start, finish, random
    )
  end

  def wall_path_generator
    Path::Generator.new(
      wall_points,
      nil, nil, random
    )
  end

  def new_edge_point(klass)
    point = edge_selector.next_point

    klass.new(point.x, point.y)
  end
end
