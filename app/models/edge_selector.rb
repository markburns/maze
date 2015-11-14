class EdgeSelector < Struct.new(:grid, :random)
  delegate :width, :height, to: :grid

  def next_point(klass=Point)
    edge_points.select{|p| p.kind_of?(klass)}.sample
  end

  def edge?(p)
    left?(p) || top?(p) || bottom?(p) || right?(p)
  end

  private

  def edge_points
    @edge_points ||= find_edges
  end

  def find_edges
    edge_points = []

    width.times do |x|
      height.times do |y|
        p = Point.new(x, y)

        edge_points.push(p) if edge?(p)
      end
    end

    edge_points
  end

  def left?(point)
    point.x == 0
  end

  def right?(point)
    point.x == width - 1
  end

  def bottom?(point)
    point.y == height - 1
  end

  def top?(point)
    point.y == 0
  end
end
