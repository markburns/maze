class MazeGenerator < Struct.new(:width, :height, :random)
  attr_writer :start, :finish
  delegate :x, :y, to: :start, prefix: true
  delegate :x, :y, to: :finish, prefix: true

  def initialize(width, height, random=Random.new)
    super
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
      maze[finish.y][finish.x] = finish
    end
  end

  private

  def edge_selector
    @edge_selector ||= EdgeSelector.new(width, height, random)
  end

  def start
    @start ||= choose_start
  end

  def finish
    @finish ||= choose_finish
  end


  def choose_start
    point = edge_selector.next_point

    StartPoint.new(point.x, point.y)
  end

  def choose_finish
    point = edge_selector.next_point

    FinishPoint.new(point.x, point.y)
  end
end
