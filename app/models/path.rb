class Path < Array
  attr_reader :dead_end

  def initialize(points=nil)
    @points = points || []
    super(@points)
  end

  def accept(visitor)
    map do |p|
      p.accept(visitor)
    end
  end

  def dead_end!
    @dead_end = true
  end
end
