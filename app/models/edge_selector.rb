class EdgeSelector < Struct.new(:width, :height, :random)
  def next_point
    point = random_point

    #TODO find a smarter way to do this
    until edge?(point)
      point = random_point
    end

    point
  end


  def edge?(p)
    left?(p) || top?(p) || bottom?(p) || right?(p)
  end

  private

  def random_point
    x = random.rand(width)
    y = random.rand(height)
    point = Point.new x, y


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
