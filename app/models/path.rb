class Path < Array
  def initialize(points=nil)
    @points = points || []
    super(@points)
  end
end
