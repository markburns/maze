class Path
  class Location < ::Point
    def self.from(other, index=0)
      new(other.x, other.y, index)
    end

    attr_accessor :index

    def initialize(x, y, index=0)
      super(x,y)
      @index = index
    end
  end
end

