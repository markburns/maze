class MazeGenerator < Struct.new(:grid, :edge_selector, :random)
  include Visitor::GridVisitable
  attr_writer :path_generator

  delegate :points, to: :maze,   prefix: true


  def maze
    @maze ||= create_maze_with_paths!
  end

  def create_maze_with_paths!
    path = nil

    begin
      create_maze!
      path = happy_path_generator.create_path!
    end until path && !path.dead_end

    @maze.set_points(*path)

    remove_all_walls!

    @maze
  end

  def remove_all_walls!
    @loops = 0
    while walls_remaining?
      @loops += 1
      start  = random_wall_point
      finish = random_wall_point

      generator = Path::Generator.new(
        wall_points,
        start, finish, random
      )

      path = generator.create_path!

      if path.any?
        @maze.set_points(*path)
      end
    end
  end

  def random_wall_point
    wall_points.sample random: random
  end

  def wall_points
    @maze.points.select{|p| p.kind_of?(Wall)}
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

  delegate :rows, to: :maze

  def happy_path_generator
    Path::Generator.new(
      @maze.points_of_type(Wall, StartPoint, FinishPoint),
      start, finish, random
    )
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
