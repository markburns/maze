class Grid < Struct.new(:width, :height)
  include Visitor::GridVisitable

  def points
    @points ||= height.times.map do |y|
      width.times.map do |x|
        Wall.new(x,y)
      end
    end
  end

  def num_points
    width * height
  end

  def set_points(*points)
    points.each{|p| set_point(p) }
  end

  def set_point(p)
    points[p.y][p.x]=p
  end
end
