class PathPoint < Point
  def self.from(other)
    new(other.x, other.y)
  end

  def to_s
    "."
  end
end

