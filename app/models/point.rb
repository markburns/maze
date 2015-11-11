class Point < Struct.new(:x, :y)
  include Visitable

  def adjacent_to?(other)
    return false unless other.is_a?(Point)

    horizontally_adjacent_to?(other) || vertically_adjacent_to?(other)
  end

  def horizontally_adjacent_to?(other)
    (other.y == y) && next_to?(other.x, x)
  end

  def vertically_adjacent_to?(other)
    (other.x == x) && next_to?(other.y, y)
  end

  def ==(other)
    other.kind_of?(self.class) && other.x == x && other.y == y
  end

  private

  def next_to?(a, b)
    ((a==b+1) || (a== b-1))
  end
end
