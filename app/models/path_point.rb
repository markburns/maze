class PathPoint < Point
  def self.from(other)
    new(other.x, other.y)
  end
end

