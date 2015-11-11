class Maze < Struct.new(:width, :height, :start, :finish)
  def points_accept(visitor)
    accept(visitor, :points)
  end

  def grid_accept(visitor)
    accept(visitor, :grid)
  end

  def points
    @points ||=
      begin
        grid.tap do |maze|
          add_start!(maze)
          add_finish!(maze)
        end
      end
  end

  def grid
    height.times.map do |y|
      width.times.map do |x|
        Wall.new(x,y)
      end
    end
  end

  def set_point(p)
    points[p.y][p.x]=p
  end

  private

  def accept(visitor, type)
    send(type).map do |row|
      row.map do |p|
        p.accept visitor
      end
    end
  end

  def add_start!(maze)
    maze[start.y][start.x] = start
  end

  def add_finish!(maze)
    maze[finish.y][finish.x] = finish
  end
end


