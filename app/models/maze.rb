class Maze < Grid
  attr_reader :start, :finish

  def initialize(width, height, start, finish)
    super(width, height)

    @start = start
    @finish = finish
  end

  def rows
    @rows ||= define_rows
  end

  def define_rows
    @rows = initialize_rows
    set_points(start, finish)
    @rows
  end
end
