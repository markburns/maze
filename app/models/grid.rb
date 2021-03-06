class Grid < Struct.new(:width, :height)
  include Visitor::GridVisitable

  def rows
    @rows ||= initialize_rows
  end

  def initialize_rows
    height.times.map do |y|
      width.times.map do |x|
        Wall.new(x,y)
      end
    end
  end

  def points
    rows.flatten
  end

  def points_of_type(*klasses)
    points.select{|p| klasses.any?{|k| p.kind_of?(k)}}
  end

  def num_points
    width * height
  end

  def set_points(*points)
    points.each{|p| set_point(p) }
  end

  def set_point(p)
    @rows[p.y][p.x]=p
  end
end
