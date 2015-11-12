class Point < Struct.new(:x, :y)
  include Visitor::Visitable

  def adjacent_to?(other)
    return false unless other.is_a?(Point)

    horizontally_adjacent_to?(other) || vertically_adjacent_to?(other)
  end

  def horizontally_adjacent_to?(other)
    (other.y == y) && next_to?(other.x, x)
  end

  def left_of?(other)
    horizontally_adjacent_to?(other) && one_less?(other.x, x)
  end

  def right_of?(other)
    horizontally_adjacent_to?(other) && one_more?(other.x, x)
  end

  def below?(other)
    vertically_adjacent_to?(other) && one_more?(other.y, y)
  end

  def above?(other)
    vertically_adjacent_to?(other) && one_less?(other.y, y)
  end

  def vertically_adjacent_to?(other)
    (other.x == x) && next_to?(other.y, y)
  end

  def ==(other)
    other.kind_of?(Point) && other.x == x && other.y == y
  end

  private

  def next_to?(a, b)
    one_less?(a,b) || one_more?(a,b)
  end

  def one_less?(a, b)
    a == b + 1
  end

  def one_more?(a, b)
    a == b - 1
  end
end
